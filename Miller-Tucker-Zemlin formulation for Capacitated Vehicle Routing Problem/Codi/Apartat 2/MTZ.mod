# nodes (inclos el node origen O)
set N;

# costs segons distancia (taula generada per Floyd-Warshall)
param D{(i,j) in N cross N};

# capacitat dels camions
param C;

# nombre de camions
param K;

# node origen
param O;

# demanda individual de cada node
param a {N};

# variable binaria x
var x {(i,j) in N cross N} binary, default 0;

# variable de capacitat
var u {N} <= C;

subject to Degree_Out {j in N: j!= O}:
	sum {i in N: i != j} x[i,j] = 1;
	
subject to Degree_In {i in N: i!= O}:
	sum {j in N: i != j} x[i,j] = 1;
	
subject to Depot_departures:
	sum {j in N: j != O} x[O,j] = K;	

subject to Depot_arrivals:
	sum {i in N: i != O} x[i,O] = K;	

subject to subtour_elimination {(i,j) in (N diff {O}) cross (N diff {O}): i != j}:
	u[j] >= u[i] + a[j] - C * (1 - x[i,j]);

subject to Capacity_Constraint {i in (N diff {O})}:
	a[i] <= u[i] <= C;

minimize total_cost:
	sum {i in N, j in N} D[i,j] * x[i,j];
	
	






