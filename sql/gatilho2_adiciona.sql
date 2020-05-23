CREATE TRIGGER DataInternamento
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
    DELETE FROM Evento WHERE EventoID=New.EventoID;
END;