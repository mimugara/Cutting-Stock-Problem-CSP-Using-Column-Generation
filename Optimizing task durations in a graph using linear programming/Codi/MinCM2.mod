# definim els nodes, els nodes/tasques origen i els arcs del graf
set nusos;
set origins within nusos;
set links within ( nusos cross nusos );


# definim les variables tau i temps.
var tau { (i, j) in links };
var t { i in nusos };


# establim els paràmetres tau màxim, tau mínim i el node on acaba el graf
param taumax{links};
param taumin{links};
param final_ob;


# establim la restricció de que el/s node/s inicial/s té/tenen temps 0
subject to initialvalue {i in origins}:
t[i] = 0;


# establim les següents restriccions tal i com ens diu l’enunciat
subject to maxmin { (i, j) in links}:
taumin[i, j] <= tau[i, j] <= taumax[i, j];

subject to minrule { (i, j) in links}:
t[i] + tau[i, j] - t[j] <= 0;

# volem minimitzar el temps en recórrer el graf (que és el mateix que el temps en 
# que acaba d’executar-se la tasca t_n)
minimize Vg: t[final_ob];