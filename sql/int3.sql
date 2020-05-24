.mode columns
.headers on
.nullvalue NULL

CREATE VIEW Stats AS
    SELECT DoencaID, DataInicio, DataFim, Doenca.Nome, Descricao, GrupoSanguineo, Sexo, DataNascimento
        FROM (
            Ocorrencia
            INNER JOIN Doenca ON Ocorrencia.Doenca=Doenca.DoencaID
            INNER JOIN (Paciente NATURAL JOIN Pessoa) ON Ocorrencia.Paciente=Paciente.PessoaID
        );

CREATE VIEW OcorrenciaFemaleCounter AS
    SELECT DoencaID, COUNT(*) as CounterFemale
        	FROM Stats WHERE Sexo='F' GROUP BY DoencaID;

CREATE VIEW OcorrenciaGSCounter AS
    SELECT DoencaID, GrupoSanguineo, COUNT(*) as CounterGS
        FROM Stats GROUP BY DoencaID, GrupoSanguineo;

CREATE VIEW OcorrenciaFemaleAvgAge AS
    SELECT DoencaID, SUM(julianday(DataInicio)-julianday(DataNascimento))/(COUNT(*))/(365.2425) AS AvgFemaleAge
        FROM Stats WHERE Sexo='F' GROUP BY DoencaID;

CREATE VIEW OcorrenciaMaleAvgAge AS
    SELECT DoencaID, SUM(julianday(DataInicio)-julianday(DataNascimento))/(COUNT(*))/(365.2425) AS AvgMaleAge
        FROM Stats WHERE Sexo='M' GROUP BY DoencaID;

SELECT
    Nome,
    Descricao,
    printf("%.2f", AvgDurationDays) AS AvgDurationDays,
    GrupoSanguineo AS 'GS Mais Afetado',
    printf("%.2f", (CounterFemale * 1.0)/(CounterOcorrencia)) AS 'Perc Female',
    printf("%.2f", 1-(CounterFemale * 1.0)/(CounterOcorrencia)) AS 'Perc Male',
    printf("%.2f", AvgFemaleAge) AS AvgFemaleAge,
    printf("%.2f", AvgMaleAge) AS AvgMaleAge

FROM (
    (SELECT DISTINCT DoencaID, Nome, Descricao FROM Stats)
    NATURAL JOIN (
                    SELECT DoencaID, COUNT(*) as CounterOcorrencia
                        FROM (Ocorrencia INNER JOIN Doenca ON Ocorrencia.Doenca=Doenca.DoencaID) GROUP BY DoencaID
                 )
    NATURAL JOIN (
                    SELECT DoencaID, CounterFemale
                        FROM OcorrenciaFemaleCounter
                    UNION
                    SELECT DoencaID, 0 as CounterFemale
                        FROM Stats
                            WHERE DoencaID NOT IN (SELECT DoencaID FROM OcorrenciaFemaleCounter)
                 )
    NATURAL JOIN (
                    SELECT DoencaID, GrupoSanguineo, CounterGS
                        FROM OcorrenciaGSCounter
                            WHERE CounterGS=(
                                                SELECT MAX(CounterGS)
                                                    FROM OcorrenciaGSCounter AS Aux
                                                        WHERE OcorrenciaGSCounter.DoencaID=Aux.DoencaID
                                            )
                                GROUP BY DoencaID
                )
    NATURAL JOIN (
                    SELECT DoencaID, SUM(julianday(DataFim)-julianday(DataInicio))/(COUNT(*)) AS AvgDurationDays
                        FROM Stats
                            WHERE DataFim IS NOT NULL
                                GROUP BY DoencaID
                )
    NATURAL JOIN (
                    SELECT DoencaID, AvgFemaleAge
                        FROM OcorrenciaFemaleAvgAge
                    UNION
                        SELECT DoencaID, 0.0 AS AvgFemaleAge
                            FROM Stats
                                WHERE DoencaID NOT IN (SELECT DoencaID FROM OcorrenciaFemaleAvgAge)
                 )
    NATURAL JOIN (
                    SELECT DoencaID, AvgMaleAge
                        FROM OcorrenciaMaleAvgAge
                    UNION
                        SELECT DoencaID, 0.0 AS AvgMaleAge
                            FROM Stats
                                WHERE DoencaID NOT IN (SELECT DoencaID FROM OcorrenciaMaleAvgAge)
                 )
);

DROP VIEW Stats;
DROP VIEW OcorrenciaFemaleCounter;
DROP VIEW OcorrenciaGSCounter;
DROP VIEW OcorrenciaFemaleAvgAge;
DROP VIEW OcorrenciaMaleAvgAge;
