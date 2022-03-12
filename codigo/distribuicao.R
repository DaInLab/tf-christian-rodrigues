library(readxl)

worksheet <- read_excel("./dados/covid_19_bauru_mortes.xlsx")

data <- worksheet$'idade'

table <- data.frame(t(table(data)))[,-1]
table$data <- as.numeric(levels(table$data))
table <- table %>% 
  mutate(Fr = 100*Freq/sum(Freq),
         Fac = cumsum(Freq),
         Xi.Fi = data*Freq)
View(table)
print(table)

dev.off()

# Subtrair data_obito por inicio_sintoma
# Media de dias de permanencia por tipo_hosp
# Gráfico de Barras
# https://pt.stackoverflow.com/questions/308496/no-r-como-calcular-a-m%C3%A9dia-de-uma-coluna-baseado-em-outra