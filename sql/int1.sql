.mode columns
.headers on
.nullvalue NULL

SELECT GrupoSanguineo, printf("%.2f", COUNT(*) / (SUM(COUNT(*)) OVER() / 100.0)) as 'Percentage (%)'
    FROM Paciente
        GROUP BY GrupoSanguineo;
