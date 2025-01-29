create database Dashboard_IF 

CREATE TABLE dbo.Ativos(
	id_Ativo INT PRIMARY KEY IDENTITY,
	ticker_Ativo VARCHAR(50) NOT NULL,
	nome_Ativo VARCHAR(50) NOT NULL,
	categoria_Ativo VARCHAR(20)
);



CREATE TABLE dbo.historicos_precos(
	id_Preco INT PRIMARY KEY IDENTITY,
	id_ativo_Preco INT NOT NULL,
	data_Preco DATETIME DEFAULT GETDATE(),
	Preco_fechamento DECIMAL(10,2) NOT NULL,
	volume_Preco BIGINT NOT NULL

	FOREIGN KEY (id_ativo_Preco) REFERENCES Ativos(id_Ativo)
);

CREATE TABLE dbo.indicadores_economicos(
	id_Indicador INT PRIMARY KEY IDENTITY,
	nome_Indicador VARCHAR(50) NOT NULL,
	data_Indicador DATETIME, 
	valor_Indicador DECIMAL(10,2) NOT NULL
)

