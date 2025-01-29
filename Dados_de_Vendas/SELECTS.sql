select 
	P.nome_Produtos as Produtos,
	SUM(V.quantidade_Vendas) AS QUANTIDADE
from
	Vendas V
INNER JOIN	
	Produtos P
ON V.ID_PRODUTO = P.ID_Produtos
GROUP BY P.nome_Produtos
ORDER BY QUANTIDADE DESC 


SELECT 
    YEAR(data_Vendas) AS ano,
    MONTH(data_Vendas) AS mes,
    COUNT(ID_Vendas) AS total_vendas,
    SUM(quantidade_Vendas) AS total_quantidade,
    SUM(P.preco_Produto * V.quantidade_Vendas) AS total_faturado
FROM Vendas V
JOIN Produtos P ON V.ID_PRODUTO = P.ID_Produtos
GROUP BY YEAR(data_Vendas), MONTH(data_Vendas)
ORDER BY ano DESC, mes DESC;


SELECT 
   -- C.nome_Clientes AS cliente,
	P.nome_Produtos as Produto,
    YEAR(V.data_Vendas) AS ano,
    MONTH(V.data_Vendas) AS mes,
	
    COUNT(V.ID_Vendas) AS total_vendas,
    SUM(V.quantidade_Vendas) AS total_quantidade,
    SUM(P.preco_Produto * V.quantidade_Vendas) AS total_ganho
FROM Vendas V
JOIN Clientes C ON V.ID_CLIENTE = C.ID_Clientes
JOIN Produtos P ON V.ID_PRODUTO = P.ID_Produtos
GROUP BY P.nome_Produtos, YEAR(V.data_Vendas), MONTH(V.data_Vendas)
ORDER BY Produto, ano DESC, mes DESC;



SELECT 
    YEAR(V.data_Vendas) AS ano,
    MONTH(V.data_Vendas) AS mes,
	FORMAT(CAST(SUM(P.preco_Produto * V.quantidade_Vendas) AS REAL), 'C', 'pt-BR') AS total_ganho
FROM Vendas V
JOIN Clientes C ON V.ID_CLIENTE = C.ID_Clientes
JOIN Produtos P ON V.ID_PRODUTO = P.ID_Produtos
WHERE YEAR(V.data_Vendas) = 2024
GROUP BY YEAR(V.data_Vendas), MONTH(V.data_Vendas)
ORDER BY ano DESC, mes DESC
;
