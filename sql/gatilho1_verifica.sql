.mode columns
.headers on
.nullvalue NULL

.print Insert new test patient
.echo on

INSERT INTO Pessoa (PessoaID, NumIdentificacao, Nome, Morada, Telefone, NumeroBeneficiario, Sexo, DataNascimento)
            VALUES (167543, 123123123123, "Subject A", "Doll House", 987987987987, 456456456, "F", "2000-10-12 00:00:00");
INSERT INTO Paciente (PessoaID, GrupoSanguineo) VALUES (167543, "O+");

INSERT INTO Doenca (DoencaID, Nome, Descricao, Sintomas)
            VALUES (123123123, "Doença Teste", "Teste", "Testing");

.print Verify that it fails to add with date before born
.print BEFORE
SELECT * FROM Ocorrencia WHERE OcorrenciaID > 450000000;

INSERT INTO Ocorrencia (OcorrenciaID, DataInicio, DataFim, Paciente, Doenca)
    VALUES (456456456, "2000-06-14 23:49:32", "2002-06-14 23:49:32", 167543, 123123123);

.print AFTER
SELECT * FROM Ocorrencia WHERE OcorrenciaID > 450000000;

.print Valid Insert
INSERT INTO Ocorrencia (OcorrenciaID, DataInicio, DataFim, Paciente, Doenca)
    VALUES (456456456, "2001-06-14 23:49:32", "2002-06-14 23:49:32", 167543, 123123123);

.print Verify it invalidates updates
.print BEFORE
SELECT * FROM Ocorrencia WHERE OcorrenciaID > 450000000;

UPDATE Ocorrencia SET DataInicio="2000-06-14 23:49:32" WHERE OcorrenciaID = 456456456;

.print AFTER
SELECT * FROM Ocorrencia WHERE OcorrenciaID > 450000000;

.echo off
DELETE FROM Ocorrencia WHERE OcorrenciaID=456456456;
DELETE FROM Doenca WHERE DoencaID=123123123;
DELETE FROM Paciente WHERE PessoaID=167543;
DELETE FROM Pessoa WHERE PessoaID=167543;
