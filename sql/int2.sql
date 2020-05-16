.mode columns
.headers on
.nullvalue NULL

SELECT DiaSemana, printf("%.2f", SUM(strftime('%s', HoraFim) - strftime('%s', HoraInicio))/ COUNT(*) / 3600.0) as Avg
    FROM ((HorarioTrabalho NATURAL JOIN Medico) NATURAL JOIN Horario)
        GROUP BY DiaSemana
UNION
SELECT DiaSemana, '0.00' as Avg FROM Horario WHERE DiaSemana NOT IN (SELECT DISTINCT DiaSemana FROM ((HorarioTrabalho NATURAL JOIN Medico) NATURAL JOIN Horario));
