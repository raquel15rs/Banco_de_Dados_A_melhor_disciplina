1.
DELIMITER //
CREATE FUNCTION total_livros_por_genero(genero_nome VARCHAR(255))
RETURNS INT
BEGIN
    DECLARE genero_id INT;
    DECLARE total_livros INT;
    SELECT id INTO genero_id FROM Genero WHERE nome_genero = genero_nome;
    SELECT COUNT(*) INTO total_livros FROM Livro WHERE id_genero = genero_id;
    RETURN total_livros;
END //
DELIMITER ;
