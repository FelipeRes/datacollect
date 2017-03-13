library(RSQLite)
library(plot3D)
setwd("C:\\Users\\Felipe Resende\\Desktop\\R\\Analise Jogo\\datacollect")
con = dbConnect(SQLite(), dbname="bancofinal.db")
dbGetQuery(con,"Select * from info")

data <- dbGetQuery(con,"Select 
(distancia_x*distancia_x) + (distancia_y * distancia_y) as dist,
count(*) as freq,
button_left, button_right, button_down, button_up, button_a, button_b, button_c
from ia
where dist not null
group by distancia_x, distancia_y, button_up,button_down,button_left,button_right,button_a,button_b,button_c
order by dist")

data

dist = sqrt(data[1])
dist = c(t(dist))
freq = data[2]
freq = c(t(freq ))
allbutton = c(as.vector(t(data[,3:9])))

matriz = matrix(freq,length(dist),7)

persp3D(c(1:7),c(1:length(dist)),t(matriz)*allbutton, border='black', xlab = "Botões",ylab = "Distância", zlab = "Frequência")

hist3D(c(1:7),c(1:length(dist)),t(matriz)*allbutton, border='black')

