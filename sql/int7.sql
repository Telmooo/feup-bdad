.mode columns
.headers on
.nullvalue NULL

SELECT DISTINCT Nome, NomeResponsavel, NomeDepartamento
    FROM ((SELECT NomeDepartamento, Paciente, Nome AS NomeResponsavel
        FROM (((SELECT Departamento.Nome as NomeDepartamento, Admissao, Medico
            FROM ((SELECT *
                FROM (Evento
NATURAL JOIN
                Consulta))
JOIN
            Departamento)
                WHERE Medico=Responsavel)
JOIN
        Pessoa)
JOIN
        Admissao)
            WHERE AdmissaoID=Admissao AND Medico=PessoaID)
JOIN
    Pessoa)
        WHERE Paciente=PessoaID
            ORDER BY Nome, NomeDepartamento;