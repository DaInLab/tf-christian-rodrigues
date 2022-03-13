# variação periódica de tais óbitos;
library(readxl)

worksheet <- read_excel("./dados/covid_19_bauru_mortes.xlsx")

data <- worksheet$'data_obito'

png(filename = "./graficos/figura5.png")
plot(data, main = "Variação Periódica de óbitos", 
     xlab = "Óbitos ocorridos", ylab = "Período/datas")

dev.off()