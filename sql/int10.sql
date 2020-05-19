/*Quais os pacientes que tiveram a doença X e tiveram uma consulta dia Y com o medico Z?*/

.mode columns
.headers on
.nullvalue NULL

SELECT * FROM Pessoa 
WHERE PessoaID IN 
(
	SELECT Paciente FROM Ocorrencia INNER JOIN Doenca ON Ocorrencia.Doenca = Doenca.DoencaID WHERE Doenca.Nome = "Ulcerative colitis"
)
AND PessoaID IN
(
	SELECT Paciente FROM Admissao 
	WHERE AdmissaoID = 
	(
		SELECT Admissao FROM Evento 
		WHERE EventoID IN 
		(
			SELECT EventoID FROM Consulta INNER JOIN Pessoa ON Consulta.Medico == Pessoa.PessoaID WHERE Nome = "Leonard Saunders"
		)
		AND Data = '2003/03/03 02:41:10'
	)
);

/*
  eventoID = 1860        
  Medico = 426
  evento.data = 2003/03/03 02:41:10 
  paciente = 9
  doenca = 215
  */