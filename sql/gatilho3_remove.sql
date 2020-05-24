/* um médico não pode ter duas consultas na mesma hora de início*/

.mode columns
.headers on
.nullvalue NULL

DROP TRIGGER IF EXISTS validar_horario_consulta_insert;
DROP TRIGGER IF EXISTS validar_horario_consulta_update;
