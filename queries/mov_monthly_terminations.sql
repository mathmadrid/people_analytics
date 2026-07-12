-- Objective: Total terminations by year and month
SELECT 
    EXTRACT(YEAR FROM termination_date) as termination_year,
    EXTRACT(MONTH FROM termination_date) as termination_month,
    COUNT(DISTINCT employee_id) as total_terminations
FROM gold."DimEmployee"
WHERE termination_date IS NOT NULL
GROUP BY EXTRACT(YEAR FROM termination_date), EXTRACT(MONTH FROM termination_date)
ORDER BY termination_year DESC, termination_month DESC;