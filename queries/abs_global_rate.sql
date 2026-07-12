-- Objective: Historical global absenteeism rate (Lost Hours / Available Hours)
WITH total_horas_falta AS (
    SELECT SUM(absence_hours) as lost_hours FROM gold."FactAbsenteeism"
),
total_horas_jornada AS (
    SELECT SUM(headcount) * 176 as available_hours FROM gold."FactHeadcount"
)
SELECT 
    f.lost_hours,
    j.available_hours,
    ROUND((f.lost_hours::numeric / j.available_hours::numeric) * 100, 2) as global_absenteeism_rate_percentage
FROM total_horas_falta f, total_horas_jornada j;