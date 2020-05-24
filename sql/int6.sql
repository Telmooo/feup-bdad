.mode columns
.headers on
.nullvalue NULL

CREATE VIEW UrgenciaPorMesAno AS
    SELECT COUNT(*) as NumVezes, MesAno, SUBSTR(MesAno,1,4) AS Ano
        FROM (SELECT SUBSTR(Data,1,7) AS MesAno
            FROM Admissao
                WHERE Urgencia=1)
            GROUP BY MesAno;

CREATE VIEW NumVezesPorMes AS
    SELECT COUNT(*) AS NumVezes, SUBSTR(MesAno,6,2) AS Mes
        FROM UrgenciaPorMesAno AS U1
            WHERE (SELECT MAX(NumVezes)
                FROM UrgenciaPorMesAno AS U2
                    WHERE U1.Ano=U2.Ano
                        GROUP BY U2.Ano)=NumVezes
                GROUP BY Mes;

SELECT *
    FROM NumVezesPorMes
        WHERE NumVezes=(SELECT Max(NumVezes)
            FROM NumVezesPorMes);

DROP View NumVezesPorMes;
DROP View UrgenciaPorMesAno;