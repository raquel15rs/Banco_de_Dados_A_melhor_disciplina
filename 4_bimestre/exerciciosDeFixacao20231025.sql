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
