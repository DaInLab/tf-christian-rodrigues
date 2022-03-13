#tipos e tempo de permanência hospitalar
library(readxl)
library(dplyr)

worksheet <- read_excel("./dados/covid_19_bauru_mortes.xlsx")

data_tp_privado <- worksheet %>% filter(tipo_hosp=="privado")
data_tp_publico <- worksheet %>% filter(tipo_hosp=="público")

entrada_pv <- data_tp_privado$'inicio_sintoma'
obito_pv <- data_tp_privado$'data_obito'

entrada_pb <- data_tp_publico$'inicio_sintoma'
obito_pb <- data_tp_publico$'data_obito'

#Função para substituir negativos por zero
neg2zero <- function(x) {
  x[x < 0] <- 0
  x
}

#Diferencia de dias e média do tipo de hospedagem PUBLICA
diff_dias_pb <- difftime(as.Date(obito_pb), as.Date(entrada_pb), units = "days")

dias_pb <- na.omit(diff_dias_pb)

dados_pb <- c(neg2zero(dias_pb))

media_pb <- mean(dados_pb)

#Diferencia de dias e média do tipo de hospedagem PRIVADA
diff_dias_pv <- difftime(as.Date(obito_pv), as.Date(entrada_pv), units = "days")

dias_pv <- na.omit(diff_dias_pv)

dados_pv <- c(neg2zero(dias_pv))

media_pv <- mean(dados_pv)

#Printing
paste("Dados da Hospedagem Pública (Dias de Permanênica)")
dados_pb
paste("Dados da Hospedagem Privada (Dias de Permanênica)")
dados_pv

paste("Média de dias de permanência em Hospedagem Pública: ", media_pb)
paste("Média de dias de permanência em Hospedagem Privada: ", media_pv)

#Graphics
dados <- c(media_pb, media_pv)
names(dados) <- c("Público", "Privado")

png(filename = "./graficos/grafico-permanencia.png", width = 700, height = 600)
barplot(as.vector(dados), main="Média de dias de permanência por tipo de hospedagem", 
        xlab="Tipos de Hospedagem", ylab="Quantidade Média de Óbitos", 
        names.arg = c ("Público", "Privado"), ylim=c(0, 25), 
        cex.names = 1, xaxs = "i", col=rainbow(2))

dev.off()