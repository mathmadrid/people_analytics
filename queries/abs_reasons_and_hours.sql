-- Objective: Lost hours and occurrence count by absence reason
SELECT 
    a.absence_type, -- Ajustado para o padrão do seu banco
    SUM(f.absence_hours) as total_lost_hours,
    COUNT(*) as total_occurrences,
    ROUND(AVG(f.absence_hours), 2) as average_hours_per_absence
FROM gold."FactAbsenteeism" f
JOIN gold."DimAbsenceType" a ON f.absence_type_sk = a.absence_type_sk
GROUP BY a.absence_type
ORDER BY total_lost_hours DESC;
