set talls;                   	# conjunt de talls
set patrons;      				# conjunt total de possibles patrons de tall 

param amplada_total_rotllo;		# amplada total dels rotllos
param longitud {patrons};		# longitud en polzades de cada patro de tall
param D {talls,patrons};		# nombre d'unitats de cada tall per cada patro
param comandes {talls};    		# nombre de comandes per un tall determinat

var X_D {patrons} >= 0;   		# rotllos tallats utilitzant un determinat patro
var unitats {patrons} >= 0; 	# unitats sobrants de cada patró

subject to ActualitzarUnitats {i in patrons}:	# unitats sobrants de cada patro de tall
    unitats[i] = X_D[i]*(amplada_total_rotllo-longitud[i])/amplada_total_rotllo;

subject to Demanda {i in talls}:				# satisfaccio de les comandes
	sum {j in patrons} X_D[j] * D[i,j] >= comandes[i];

minimize MinUnitats:							# minimitzem el consum de rotllos 
	sum {j in patrons} X_D[j];