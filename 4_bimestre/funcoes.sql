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

--Funções de Data--
CREATE TABLE eventos (
    data_evento DATE
);
INSERT INTO eventos (data_evento) VALUES
('2007-01-01'),
('1912-04-16'),
('2006-09-29'),
('2006-09-26'),
('1987-07-27');

INSERT INTO eventos (data_evento) VALUES (NOW());

SELECT MIN(data_evento) AS primeiro, MAX(data_evento) AS segundo, DATEDIFF(MAX(data_evento), MIN(data_evento)) AS distancia_tempo FROM eventos;

SELECT data_evento, DAYNAME(data_evento) AS dia_semana FROM eventos;
--Funções de Data--

--Funções de Controle de Fluxo--
SELECT produto, IF(quantidade > 0, 'Em estoque', 'Fora de estoque') AS quantidade_estoque FROM produtos;

SELECT produto, 
	CASE
        WHEN preco < 1000 THEN 'Barato'
        WHEN preco >= 2000 AND preco < 4000 THEN 'Médio'
        ELSE 'Caro'
    END 
    AS categoria_produto FROM produtos;
--Funções de Controle de Fluxo--

