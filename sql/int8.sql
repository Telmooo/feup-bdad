/*Quem são os médicos mais velhos de cada departamento?*/

.mode columns
.headers on
.nullvalue NULL

SELECT Pessoa.PessoaID, Pessoa.Nome, MIN(Pessoa.DataNascimento) AS DataNascimento, Departamento.Nome AS Departamento
    FROM    Pessoa
            INNER JOIN Medico ON Pessoa.PessoaID = Medico.StaffID
            INNER JOIN Staff ON Pessoa.PessoaID = Staff.PessoaID
            INNER JOIN Especializacao ON Staff.Especializacao = Especializacao.EspecializacaoID
            INNER JOIN Departamento ON Especializacao.Departamento = Departamento.NumIdentificador
                GROUP BY Departamento.Nome
                    ORDER BY Pessoa.Nome; 
