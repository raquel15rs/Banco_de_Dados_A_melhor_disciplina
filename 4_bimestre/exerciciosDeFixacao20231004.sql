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

2. 
DELIMITER //
CREATE FUNCTION listar_livros_por_autor(primeiro_nome VARCHAR(255), ultimo_nome VARCHAR(255))
RETURNS TABLE (titulo_livro VARCHAR(255))
BEGIN
    CREATE TEMPORARY TABLE TempTable (titulo_livro VARCHAR(255));
    DECLARE autor_id INT;
    DECLARE livro_id INT;
    DECLARE cur CURSOR FOR
    SELECT A.id, LA.id_livro
    FROM Autor A
    LEFT JOIN Livro_Autor LA ON A.id = LA.id_autor
    WHERE A.primeiro_nome = primeiro_nome AND A.ultimo_nome = ultimo_nome;
    OPEN cur;
    FETCH cur INTO autor_id, livro_id;
    WHILE FETCH_STATUS = 0 DO
        IF livro_id IS NOT NULL THEN
            INSERT INTO TempTable (titulo_livro) SELECT titulo FROM Livro WHERE id = livro_id;
        END IF;
        FETCH cur INTO autor_id, livro_id;
    END WHILE;
    CLOSE cur;
    RETURN (SELECT * FROM TempTable);
END //
DELIMITER ;
