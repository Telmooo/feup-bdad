CREATE TRIGGER DataInternamentoInsercao
BEFORE INSERT ON Internamento
FOR EACH ROW
WHEN New.EventoID IN
    (SELECT EventoID
        FROM Evento)
    AND New.DataFim < (SELECT Data
        FROM Evento
            WHERE EventoID=New.EventoID)
BEGIN
    SELECT raise(rollback, 'DataFim tem de ser inferior à data de Evento!');
END;

CREATE TRIGGER DataInternamentoAtualizacao
BEFORE UPDATE ON Internamento
FOR EACH ROW
WHEN New.EventoID IN
    (SELECT EventoID
        FROM Evento)
    AND New.DataFim < (SELECT Data
        FROM Evento
            WHERE EventoID=New.EventoID)
BEGIN
    SELECT raise(rollback, 'DataFim tem de ser inferior à data de Evento!');
END;