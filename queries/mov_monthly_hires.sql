-- Objective: Total new hires by year and month
SELECT 
    EXTRACT(YEAR FROM hire_date) as hire_year,
    EXTRACT(MONTH FROM hire_date) as hire_month,
    COUNT(DISTINCT employee_id) as total_hires
FROM gold."DimEmployee"
GROUP BY EXTRACT(YEAR FROM hire_date), EXTRACT(MONTH FROM hire_date)
ORDER BY hire_year DESC, hire_month DESC;