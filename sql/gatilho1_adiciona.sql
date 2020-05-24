.mode columns
.headers on
.nullvalue NULL

CREATE TRIGGER valid_occurence_date_insert
    BEFORE INSERT ON Ocorrencia
    WHEN New.DataInicio < ( SELECT DataNascimento
                                FROM Pessoa
                                    WHERE PessoaID=New.Paciente )
BEGIN
    SELECT RAISE(ABORT, 'Occurence date is before the patient was born');
END;

CREATE TRIGGER valid_occurence_date_update
    BEFORE UPDATE ON Ocorrencia
    WHEN New.DataInicio < ( SELECT DataNascimento
                                FROM Pessoa
                                    WHERE PessoaID=New.Paciente )
BEGIN
    SELECT RAISE(ABORT, 'Occurence date is before the patient was born');
END;
