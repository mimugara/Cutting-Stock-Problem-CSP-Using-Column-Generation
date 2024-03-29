param amplada_total_rotllo >= 0;       	# amplada total dels rollos
set talls;                 				# conjunt de talls 
param l integer >= 0;    				# índex de cada iteracio (equivalent a la quantitat de posibles patrons de tall)
set I_D := 1..l;						# conjunt complet d'indexs de patrons de tall
set patrons within I_D default 1..l; 	# conjunt de patrons definits per l’index “l”
param longitud {patrons};				# longitud en polzades de cada patro de tall
param D {talls,patrons} integer >= 0; 	# submatriu de “A” designada “D” a l’enunciat
param comandes {talls} >= 0; 			# nombre de comandes per un tall determinat

var X_D {patrons} >= 0;   				# components corresponents a les columnes de I_D
var unitats {patrons} >= 0; 			# unitats sobrants de cada patro

subject to Demanda {i in talls}:				# satisfaccio de les comandes
	sum {j in patrons} X_D[j] * D[i,j] >= comandes[i];
subject to ActualitzarUnitats {i in patrons}:	# unitats sobrants de cada patro de tall
    unitats[i] = X_D[i]*(amplada_total_rotllo-longitud[i])/amplada_total_rotllo;
    
minimize MinUnitats:							# minimitzem el consum de rotllos
	sum {j in patrons} X_D[j];
# ===============================================================
param lambda {talls} >= 0; 				# variable dual

var a {talls} integer >= 0; 			# nombre d’unitats de cada tall pel nou patro

subject to LimitAmplada: 				# limitacio d'amplada del nou patro
	sum {i in talls} i * a[i] <= amplada_total_rotllo;

minimize CostReduit: 					# minimitzem els costos reduits (problema dual)
	1 - sum {i in talls} lambda[i] * a[i];