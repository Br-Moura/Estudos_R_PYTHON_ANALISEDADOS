install.packages("odbc")
install.packages("DBI")
install.packages("odbc")
install.packages("ggplot2")

library(odbc)
library(DBI)
library(odbc)
library(ggplot2)

#CONN COM O BANCO DE DADOS 

con <- dbConnect(odbc::odbc(),
                 Driver = "SQL Server",   # ou "SQL Server Native Client 11.0", dependendo da versão
                 Server = "NOTEBOOK",  # pode ser um IP ou nome do servidor
                 Database = "bd_Aula",  # nome do banco de dados
                 UID = "sa",      # seu nome de usuário do banco
                 PWD = "1234",        # sua senha
                 Port = 1433)              # geralmente a porta padrão para SQL Server

#CONN COM O BANCO DE DADOS

#FAZER CONTAGEM DE ALUNOS POR DISCIPLINAS

query <- "SELECT curso, COUNT(*) AS total_alunos FROM Aluno GROUP BY curso"
dados <- dbGetQuery(con, query)


ggplot(dados, aes(x = reorder(curso, -total_alunos), y = total_alunos, fill = curso)) +
  geom_bar(stat = "identity") +
  labs(title = "Quantidade de Alunos por Curso",
       x = "Curso",
       y = "Total de Alunos") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#FAZER CONTAGEM DE ALUNOS POR DISCIPLINAS


#COMANDO PARA FAZER A MEDIA E CONTAGEMM DOS ALUNOS

query <- "SELECT disciplina, AVG(nota) AS media_nota, COUNT(DISTINCT id_aluno) AS total_alunos FROM Media GROUP BY disciplina ORDER BY media_nota DESC;"
dados <- dbGetQuery(con, query)

#COMANDO PARA FAZER A MEDIA E CONTAGEMM DOS ALUNOS

#Media de notas por diciplinas

ggplot(dados, aes(x = reorder(disciplina, -media_nota), y = media_nota, fill = disciplina)) +
  geom_bar(stat = "identity") +
  labs(title = "Média das Notas por Disciplina",
       x = "Disciplina",
       y = "Média das Notas") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))  # Rotaciona os nomes no eixo X

#Media de notas por diciplinas

#Media de alunos por diciplinas

ggplot(dados, aes(x = reorder(disciplina, -total_alunos), y = total_alunos, fill = disciplina)) +
  geom_bar(stat = "identity") +
  labs(title = "Número de Alunos por Disciplina",
       x = "Disciplina",
       y = "Total de Alunos") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#Media de alunos por diciplinas


dbDisconnect(con)


