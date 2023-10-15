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

3.
DELIMITER //
CREATE FUNCTION atualizar_resumos()
RETURNS VOID
BEGIN
    DECLARE livro_id INT;
    DECLARE resumo_atual TEXT;
    DECLARE cur CURSOR FOR
    SELECT id, resumo FROM Livro;
    OPEN cur;
    FETCH cur INTO livro_id, resumo_atual;
    WHILE FETCH_STATUS = 0 DO
        UPDATE Livro SET resumo = CONCAT(resumo_atual, ' Este é um excelente livro!') WHERE id = livro_id;
        FETCH cur INTO livro_id, resumo_atual;
    END WHILE;
    CLOSE cur;
END //
DELIMITER ;

4. 
DELIMITER //
CREATE FUNCTION media_livros_por_editora()
RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE total_livros INT;
    DECLARE total_editoras INT;
    DECLARE media DECIMAL(10, 2);
    SELECT COUNT(*) INTO total_livros FROM Livro;
    SELECT COUNT(*) INTO total_editoras FROM Editora;
    SET media = total_livros / total_editoras;
    RETURN media;
END //
DELIMITER ;

5. 
DELIMITER //
CREATE FUNCTION autores_sem_livros()
RETURNS TABLE (nome_autor VARCHAR(255))
BEGIN
    CREATE TEMPORARY TABLE TempTable (nome_autor VARCHAR(255));
    DECLARE autor_id INT;
    DECLARE cur CURSOR FOR
    SELECT A.id
    FROM Autor A
    WHERE NOT EXISTS (SELECT 1 FROM Livro_Autor LA WHERE LA.id_autor = A.id);
    OPEN cur;
    FETCH cur INTO autor_id;
    WHILE FETCH_STATUS = 0 DO
        INSERT INTO TempTable (nome_autor) SELECT CONCAT(primeiro_nome, ' ', ultimo_nome) FROM Autor WHERE id = autor_id;
        FETCH cur INTO autor_id;
    END WHILE;
    CLOSE cur;
    RETURN (SELECT * FROM TempTable);
END //
DELIMITER ;
