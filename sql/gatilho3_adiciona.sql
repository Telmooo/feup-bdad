/* um médico não pode ter duas consultas na mesma hora de início*/

.mode columns
.headers on
.nullvalue NULL

CREATE TRIGGER validar_horario_consulta_insert
   BEFORE INSERT ON Consulta
   WHEN 
   (
   		SELECT COUNT(*) FROM Consulta
   		INNER JOIN Evento ON Consulta.EventoID = Evento.EventoID
   		WHERE Consulta.Medico = NEW.Medico 
   		AND Evento.Data IN
   		(
   			SELECT Data FROM Evento WHERE NEW.EventoID = Evento.EventoID
   		)

   ) > 0
BEGIN
	SELECT RAISE (ABORT, "Medico ja possui consulta nesse horario");
END;

CREATE TRIGGER validar_horario_consulta_update
   BEFORE UPDATE ON Evento
   WHEN 
   (
   		SELECT COUNT(*) FROM Evento
   		INNER JOIN Consulta ON Consulta.EventoID = Evento.EventoID
   		WHERE Evento.Data = NEW.Data 
   		AND Consulta.Medico IN
   		(
   			SELECT Medico FROM Consulta WHERE NEW.EventoID = Consulta.EventoID
   		)

   ) > 0
BEGIN
	SELECT RAISE (ABORT, "Medico ja possui consulta no novo horario");
END;