.mode columns
.headers on
.nullvalue NULL

SELECT Nome, Consultorio
    FROM Pessoa
JOIN
    Medico ON (PessoaID=StaffID)
        ORDER BY Consultorio;