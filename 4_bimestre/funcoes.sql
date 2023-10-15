--Funções de String--
CREATE TABLE nomes(
	nome VARCHAR(255)
);
INSERT INTO nomes VALUES
('Roberta'),
('Roberto'),
('Maria Clara'),
('João');

SELECT UPPER(nome) AS nomes FROM nomes;

SELECT nome, LENGTH(nome) AS tamanho FROM nomes;

SELECT CONCAT(IF(nome = 'Maria Clara' or nome = 'Roberta', 'Sra. ', 'Sr. '), nome) AS nome FROM nomes;
--Funções de String--

--Funções Numéricas--
CREATE TABLE produtos(
	produto VARCHAR(255),
	preco DECIMAL(15,3),
	quantidade INT
);

SELECT produto, ROUND(preco, 2) AS preco_arredondado FROM produtos;

SELECT produto, ABS(quantidade) AS quantidade_absoluta FROM produtos;

SELECT produto, AVG(preco) AS preco_medio FROM produtos GROUP BY produto;
--Funções Numéricas--
