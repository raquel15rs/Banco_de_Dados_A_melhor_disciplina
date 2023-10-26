CREATE TRIGGER apos_inserir_clientes
  BEFORE INSERT ON Clientes
	FOR EACH ROW 
INSERT INTO Auditoria (mensagem) VALUES ('Concluído');
