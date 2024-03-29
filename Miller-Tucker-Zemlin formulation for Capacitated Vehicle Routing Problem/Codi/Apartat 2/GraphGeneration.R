library(igraph)

mat <- scan('/home/cristian/Escriptori/Uni/IO/Ex2/Codi/Apartat 2/Taula5.txt')
mat <- matrix(mat, ncol = 24, byrow = TRUE)
# mat

g <- graph_from_adjacency_matrix( mat )

clientNodes <- c(3,5,8,12,13,14,17,18,19,21,23) # nodes marcats manualment segons les especificacions del problema

V(g)[clientNodes]$color <- "gold"

lo <- layout_with_kk(g) # es crea un layout

lo <- norm_coords(lo, ymin=-1, ymax=1, xmin=-1, xmax=1)

plot(g, edge.arrow.width = .75,
     edge.arrow.size = .75,
     vertex.size = 14, 
     rescale=FALSE, 
     layout=lo*1)
