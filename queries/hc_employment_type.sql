-- Objective: Distribution of employment types (CLT, PJ, etc.) in current headcount
SELECT 
    t.employment_type,
    SUM(f.headcount) as total_employees,
    ROUND((SUM(f.headcount)::numeric / SUM(SUM(f.headcount)) OVER ()::numeric) * 100, 2) as percentage_share
FROM gold."FactHeadcount" f
JOIN gold."DimEmploymentType" t ON f.employment_type_sk = t.employment_type_sk
WHERE f.date_sk = (SELECT MAX(date_sk) FROM gold."FactHeadcount")
GROUP BY t.employment_type
ORDER BY total_employees DESC;