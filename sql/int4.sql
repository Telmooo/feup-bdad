.mode columns
.headers on
.nullvalue NULL

SELECT Count(DISTINCT Paciente) AS NumPacientes, SUBSTR(Data,6,2) AS Mes 
    FROM Admissao
        GROUP BY Mes;