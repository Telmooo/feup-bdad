/*Qual o departamento que realiza mais intervenções em mulheres?*/

.mode columns
.headers on
.nullvalue NULL


SELECT Departamento.Nome AS Departamento, COUNT(Departamento.Nome) AS Intevencoes_em_Mulheres
	FROM 	Departamento
			INNER JOIN Especializacao ON Departamento.NumIdentificador = Especializacao.Departamento
			INNER JOIN Staff ON Staff.Especializacao = Especializacao.EspecializacaoID
			WHERE Staff.PessoaID IN
				(
					SELECT EnfermeiroID
						FROM EnfermeiroInterv
							INNER JOIN Evento ON EnfermeiroInterv.EnfermeiroID = Evento.EventoID
							INNER JOIN Admissao ON Admissao.AdmissaoID = Evento.Admissao
							INNER JOIN Pessoa ON Pessoa.PessoaID = Admissao.Paciente
								WHERE Pessoa.Sexo = "F"

					UNION

					SELECT MedicoID
						FROM MedicoInterv
							INNER JOIN Evento ON MedicoInterv.MedicoID = Evento.EventoID
							INNER JOIN Admissao ON Admissao.AdmissaoID = Evento.Admissao
							INNER JOIN Pessoa ON Pessoa.PessoaID = Admissao.Paciente
								WHERE Pessoa.Sexo = "F"

					UNION

					SELECT TecnicoId
						FROM TecnicoInterv
							INNER JOIN Evento ON TecnicoInterv.IntervID = Evento.EventoID
							INNER JOIN Admissao ON Admissao.AdmissaoID = Evento.Admissao
							INNER JOIN Pessoa ON Pessoa.PessoaID = Admissao.Paciente
								WHERE Pessoa.Sexo = "F"
				)
				GROUP BY Departamento.Nome
					ORDER BY COUNT(Departamento.Nome) DESC
						LIMIT 1;
