/* um médico não pode ter duas consultas na mesma hora de início*/

.mode columns
.headers on
.nullvalue NULL

UPDATE Evento SET Data =  "2012-01-22 10:11:38" WHERE EventoID = 1865;

DELETE FROM Consulta WHERE EventoID = 9999;
DELETE FROM Evento WHERE EventoID = 9999;
INSERT INTO Evento(EventoID,Descricao, Data, Admissao, Quarto) VALUES (9999, "descricao","2012-01-22 10:11:38" ,154, 238);
INSERT INTO Consulta( EventoID, Diagnostico, Medico) VALUES (9999,"Porphyria",389);
