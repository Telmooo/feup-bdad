.mode columns
.headers on
.nullvalue NULL

.echo on

SELECT EventoID, Data, DataFim FROM (Evento NATURAL JOIN Internamento) WHERE Ativo=0 AND EventoID>2740;

INSERT INTO Evento(EventoID,Descricao,Data,Admissao,Quarto) VALUES (2750,"descricao","1989-12-10 00:00:01",1,101);
INSERT INTO Internamento(EventoID,Motivo,DataFim,Ativo) VALUES (2750,"Asthma","1989-12-10 00:00:02",0);

INSERT INTO Evento(EventoID,Descricao,Data,Admissao,Quarto) VALUES (2751,"descricao","1995-10-04 00:00:01",2,102);
INSERT INTO Internamento(EventoID,Motivo,DataFim,Ativo) VALUES (2751,"Lyme disease","1995-10-04 00:00:00",0);

SELECT EventoID, Data, DataFim FROM (Evento NATURAL JOIN Internamento) WHERE Ativo=0 AND EventoID>2740;

UPDATE Internamento SET DataFim="1989-12-10 00:00:03" WHERE EventoID = 2750;

UPDATE Internamento SET DataFim="1989-12-10 00:00:00" WHERE EventoID = 2750;

SELECT EventoID, Data, DataFim FROM (Evento NATURAL JOIN Internamento) WHERE Ativo=0 AND EventoID>2740;

.echo off
