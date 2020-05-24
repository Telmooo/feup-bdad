.mode columns
.headers on
.nullvalue NULL

SELECT Nome, Consultorio
    FROM (Pessoa
JOIN
    Medico)
        WHERE PessoaID=StaffID
            ORDER BY Consultorio;