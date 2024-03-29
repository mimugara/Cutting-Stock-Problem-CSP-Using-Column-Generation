# nodes
set N;	
							
# arcs
set links within {N, N}; 			

# costs
param cost {links} default 0;		

# carreguem les dades del problema
#data /path/fins/el/fitxer/Floyd-Warshall.dat
data  /home/cristian/Escriptori/Uni/IO/Ex2/P2/ap1.dat;

# Matriu de distancies
param D {N,N} default Infinity;    	

# Matriu de predecessors
param P {N,N} default 0;	     	

for {(i,j) in links} {
  let P[i,j] := i;
  let D[i,j] := cost[i,j];
}

for {i in N} {
	let D[i,i] := 0;
}

for {l in N} 
	for {i in N} 
  		for {j in N} 
		    if i != j and D[i,j] > D[i,l] + D[l,j] then {
		      let D[i,j] := D[i,l] + D[l,j];
		      let P[i,j] := P[l,j];
			}


# Mostrem les matrius
printf "\nMatriu de distancies mínimes:\n";
printf "Origen\tDestí\tDistancia\tPredecessor\n";
#printf "Origen\tDestí\tDistancia\n";
for {i in  N, j in N} 
	printf "%d\t%d\t%s\t\t%d\n",i,j,round(D[i,j],2),P[i,j];
	#printf "%d\t%d\t%s\n",i,j,round(D[i,j],2);


# Com que els costs amb què treballem sempre seran positius, ignorem els potencials cicles de cost negatiu.
