create database Dados_de_Vendas;
go

use Dados_de_Vendas

CREATE TABLE Clientes(
	ID_Clientes INT PRIMARY KEY IDENTITY,
	nome_Clientes VARCHAR(60) NOT NULL,
	email_Clientes VARCHAR(30) NULL,
	telefone_Clientes VARCHAR(14) NOT NULL,
	endereco_Clientes TEXT NOT NULL,
	dataC_Clientes DATETIME DEFAULT GETDATE()
);

CREATE TABLE Produtos(
	ID_Produtos INT PRIMARY KEY IDENTITY,
	nome_Produtos VARCHAR(50) NOT NULL,
	categoria_Produtos VARCHAR(20) NOT NULL, 
	preco_Produto DECIMAL(10,2) NOT NULL,
	estoque_Produto INT NOT NULL
);

CREATE TABLE Vendas(
	ID_Vendas INT PRIMARY KEY IDENTITY,
	ID_CLIENTE INT NOT NULL,
	ID_PRODUTO INT NOT NULL,
	quantidade_Vendas INT NOT NULL,
	data_Vendas DATETIME DEFAULT GETDATE(),

	FOREIGN KEY (ID_CLIENTE) REFERENCES Clientes(ID_Clientes),
	FOREIGN KEY (ID_PRODUTO) REFERENCES Produtos(ID_Produtos)
);

