/* um médico não pode ter duas consultas na mesma hora de início*/

.mode columns
.headers on
.nullvalue NULL


SELECT * FROM Consulta NATURAL JOIN Evento WHERE Data = "2012-01-22 10:11:38";
SELECT * FROM Consulta NATURAL JOIN Evento WHERE EventoID = 1865;

UPDATE Evento SET Data =  "2016-02-30 07:12:00" WHERE EventoID = 1865;



SELECT * FROM Consulta NATURAL JOIN Evento WHERE EventoID = 1865;

UPDATE Evento SET Data =  "2012-01-22 10:11:38" WHERE EventoID = 1865;

SELECT * FROM Consulta NATURAL JOIN Evento WHERE EventoID = 1865;


SELECT * FROM Consulta NATURAL JOIN Evento WHERE EventoID = 9999;

DELETE FROM Consulta WHERE EventoID = 9999;
DELETE FROM Evento WHERE EventoID = 9999;
INSERT INTO Evento(EventoID,Descricao, Data, Admissao, Quarto) VALUES (9999, "descricao","2017-03-02 21:35:12" ,154, 238);
INSERT INTO Consulta( EventoID, Diagnostico, Medico) VALUES (9999,"Porphyria",389);

SELECT * FROM Consulta NATURAL JOIN Evento WHERE EventoID = 9999;



SELECT * FROM Consulta NATURAL JOIN Evento WHERE EventoID = 9999;

DELETE FROM Consulta WHERE EventoID = 9999;
DELETE FROM Evento WHERE EventoID = 9999;
INSERT INTO Evento(EventoID,Descricao, Data, Admissao, Quarto) VALUES (9999, "descricao","2012-01-22 10:11:38" ,154, 238);
INSERT INTO Consulta( EventoID, Diagnostico, Medico) VALUES (9999,"Porphyria",389);

SELECT * FROM Consulta NATURAL JOIN Evento WHERE EventoID = 9999;
