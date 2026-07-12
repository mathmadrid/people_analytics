-- Objective: Current active headcount by department
SELECT 
    d.department_name,
    SUM(f.headcount) as total_headcount
FROM gold."FactHeadcount" f
JOIN gold."DimDepartment" d ON f.department_sk = d.department_sk
WHERE f.date_sk = (SELECT MAX(date_sk) FROM gold."FactHeadcount")
GROUP BY d.department_name
ORDER BY total_headcount DESC;