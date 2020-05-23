.mode columns
.headers on
.nullvalue NULL

SELECT *
    FROM (SELECT COUNT(*) AS NumVezes, SUBSTR(MesAno,6,2) AS Mes
        FROM (SELECT COUNT(*) AS NumVezes, MesAno, SUBSTR(MesAno,1,4) AS Ano
            FROM (SELECT SUBSTR(Data,1,7) AS MesAno
                FROM Admissao
                    WHERE Urgencia=1)
                GROUP BY MesAno)
            WHERE (SELECT MAX(NumVezes)
                FROM (SELECT COUNT(*) as NumVezes, MesAno, SUBSTR(MesAno,1,4) AS MaxAno
                    FROM (SELECT SUBSTR(Data,1,7) AS MesAno
                        FROM Admissao
                            WHERE Urgencia=1)
                        GROUP BY MesAno)
                    WHERE Ano=MaxAno
                        GROUP BY MaxAno)=NumVezes
                GROUP BY Mes)
        WHERE NumVezes=(SELECT Max(Contagem)
            FROM (SELECT Count(*) AS Contagem, SUBSTR(MesAno,6,2) AS Mes
                FROM (SELECT COUNT(*) AS NumVezes, MesAno, SUBSTR(MesAno,1,4) AS Ano
                    FROM (SELECT SUBSTR(Data,1,7) AS MesAno
                        FROM Admissao
                            WHERE Urgencia=1)
                        GROUP BY MesAno)
                    WHERE NumVezes=(SELECT MAX(NumVezes)
                        FROM (SELECT COUNT(*) as NumVezes, MesAno, SUBSTR(MesAno,1,4) AS MaxAno
                            FROM (SELECT SUBSTR(Data,1,7) AS MesAno
                                FROM Admissao
                                    WHERE Urgencia=1)
                                GROUP BY MesAno)
                            WHERE Ano=MaxAno
                                GROUP BY MaxAno)
                        GROUP BY Mes));