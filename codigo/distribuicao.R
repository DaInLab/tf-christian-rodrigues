#distribuição de acordo com a idade dos pacientes
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

png(filename = "./graficos/figura1.png")
hist(data, main = "Distribuição de Frequência das Idades", 
     xlab = "Idades", ylab= "Frequências", col=rainbow(1))

dev.off()
