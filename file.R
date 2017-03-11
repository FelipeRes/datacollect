library(RSQLite)
library(plot3D)
setwd("C:\\Users\\Felipe Resende\\Desktop\\R\\Analise Jogo")
con = dbConnect(SQLite(), dbname="aidata.db")
dbGetQuery(con,"Select * from info")

data <- dbGetQuery(con,"Select 
(distancia_x*distancia_x) + (distancia_y * distancia_y) as dist,
count(*) as freq,
(button_left*1 + button_right*2 + button_down*4 + button_up*8 + button_a*16 + button_b*32 + button_c*64) as command
from info
where dist not null
group by distancia_x, distancia_y, button_up,button_down,button_left,button_right,button_a,button_b,button_c
order by dist")

data <- dbGetQuery(con,"Select 
(distancia_x*distancia_x) + (distancia_y * distancia_y) as dist,
count(*) as freq,
(button_left*1 + button_right*2) as command
from info
where dist not null
group by distancia_x, distancia_y, button_up,button_down,button_left,button_right,button_a,button_b,button_c
order by dist")

dist = sqrt(data[1])
dist = c(t(dist))
freq = data[2]
freq = c(t(freq ))
command = data[3]
command = c(t(command))
plot(dist,command)
plot(dist,freq)
plot(freq,command)

z <- matrix(freq,length(dist),length(command))

scatter3D(dist,command,freq)
text3D(dist,command,freq)

scatter3D(dist, command, freq, phi = 45, theta = 45, bty = "g", 
pch = 20, cex = 2, ticktype = "detailed")




