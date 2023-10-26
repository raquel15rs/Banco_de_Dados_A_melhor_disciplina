CREATE TRIGGER apos_inserir_clientes
	BEFORE INSERT ON Clientes
	FOR EACH ROW 
INSERT INTO Auditoria (mensagem) VALUES ('Concluído');

CREATE TRIGGER antes_deletar_clientes
	AFTER DELETE ON Clientes
	FOR EACH ROW
INSERT INTO Auditoria (mensagem) VALUES ('Excluído');

CREATE TRIGGER depois_atualizar_clientes
	BEFORE UPDATE ON Clientes
	FOR EACH ROW
INSERT INTO Auditoria (mensagem) VALUES (concat(old.nome, new.nome));

DELIMITER //
CREATE TRIGGER cliente_vazio
	BEFORE UPDATE ON Clientes
	FOR EACH ROW
	IF new.nome is NULL or new.nome = '' THEN
		UPDATE Clientes SET nome = old.nome;
		INSERT INTO Auditoria (mensagem) VALUES ('Cliente vazio');
	END IF;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER apos_inserir_pedidos
	BEFORE INSERT ON Pedidos
    FOR EACH ROW
    UPDATE Produtos SET estoque = estoque - new.quantidade WHERE id = new.produto_id;
    DECLARE x_estoque INT;
    SET x_estoque = (SELECT estoque FROM Produtos WHERE id = NEW.produto_id);
    IF x_estoque < 5 THEN
		INSERT INTO Auditoria (mensagem) VALUES ('Menos de 5 no estoque')
	END IF;
//
DELIMITER ;
