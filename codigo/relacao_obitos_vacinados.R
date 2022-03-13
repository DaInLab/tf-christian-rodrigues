#relação entre óbitos ocorridos e a vacinação dos falecidos.
library(readxl)
library(dplyr)

worksheet <- read_excel("./dados/covid_19_bauru_mortes.xlsx")

doses_vacina <- worksheet$'doses_vacina'

doses_true <- worksheet %>% filter(doses_vacina=='TRUE')

total_obito <- count(worksheet, "doses_vacina")

total_true <- count(doses_true, "doses_vacina")

total_nao_vacinados <- total_obito[2] - total_true[2]

dados <- as.numeric(c(total_obito[2], total_nao_vacinados, total_true[2]))

names(dados) <- c("Total de Óbitos", "Total de Óbitos Não Vacinados", "Total de Óbitos Vacidos")

png(filename = "./graficos/figura3.png", width = 900, height = 500)
barplot(as.vector(dados), main="Quantidade de Óbitos, parâmentro de vacinados e não vacinados", 
        ylab="Taxas", ylim=c(0, 1200), cex.names = 1, 
        names.arg = c("Total de Óbitos", "Total de Óbitos Não Vacinados", "Total de Óbitos Vacidos"),
        xaxs = "i", col=rainbow(3))

dev.off()