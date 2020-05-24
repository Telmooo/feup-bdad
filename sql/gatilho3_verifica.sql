/* um medico nao pode ter duas consultas na mesma hora de inicio*/

.mode columns
.headers on
.nullvalue NULL

.print Tenta inserir consulta em horario indisponivel
.echo on
INSERT INTO Evento(EventoID,Descricao, Data, Admissao, Quarto) VALUES (9999, "descricao","2012-01-22 10:11:38" ,154, 238);
INSERT INTO Consulta( EventoID, Diagnostico, Medico) VALUES (9999,"Porphyria",389);

.print Verifica que a insercao falhou
SELECT * FROM Consulta NATURAL JOIN Evento WHERE EventoID = 9999;

DELETE FROM Consulta WHERE EventoID = 9999;
DELETE FROM Evento WHERE EventoID = 9999;



.print Tenta inserir consulta com horario valido
INSERT INTO Evento(EventoID,Descricao, Data, Admissao, Quarto) VALUES (9999, "descricao","2017-02-23 10:11:38" ,154, 238);
INSERT INTO Consulta( EventoID, Diagnostico, Medico) VALUES (9999,"Porphyria",389);

.print Verifica que insercao foi bem sucedida 
SELECT * FROM Consulta NATURAL JOIN Evento WHERE EventoID = 9999;

DELETE FROM Consulta WHERE EventoID = 9999;
DELETE FROM Evento WHERE EventoID = 9999;




.print Tenta fazer update para horario indisponivel
UPDATE Evento SET Data =  "2012-01-22 10:11:38" WHERE EventoID = 1865;

.print Verifica que update falhou 
SELECT * FROM Consulta NATURAL JOIN Evento WHERE EventoID = 1865;



.print Tenta fazer update pra horario disponivel
UPDATE Evento SET Data =  "2017-01-23 10:11:38" WHERE EventoID = 1865;

.print Verifica que update funcionou
SELECT * FROM Consulta NATURAL JOIN Evento WHERE EventoID = 1865;

.echo no