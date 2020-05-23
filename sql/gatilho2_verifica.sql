.mode columns
.headers on
.nullvalue NULL

SELECT EventoID, Data, DataFim FROM (Evento NATURAL JOIN Internamento) WHERE Ativo=0;
SELECT '';

INSERT INTO Evento(EventoID,Descricao,Data,Admissao,Quarto) VALUES (2750,"descricao","1989-12-10 00:00:00",1,101);
INSERT INTO Internamento(EventoID,Motivo,DataFim,Ativo) VALUES (2750,"Asthma","1989-12-10 00:00:01",0);

INSERT INTO Evento(EventoID,Descricao,Data,Admissao,Quarto) VALUES (2751,"descricao","1995-10-04 00:00:01",2,102);
INSERT INTO Internamento(EventoID,Motivo,DataFim,Ativo) VALUES (2751,"Lyme disease","1995-10-04 00:00:00",0);

INSERT INTO Evento(EventoID,Descricao,Data,Admissao,Quarto) VALUES (2752,"descricao","2003-03-31 00:00:00",3,103);
INSERT INTO Internamento(EventoID,Motivo,DataFim,Ativo) VALUES (2752,"Congestive heart disease","2003-03-30 23:59:59",0);

SELECT '';
SELECT EventoID, Data, DataFim FROM (Evento NATURAL JOIN Internamento) WHERE Ativo=0;