-- Objective: Turnover rate calculation for the latest processed month
WITH hc_atual AS (
    SELECT SUM(headcount) as total_hc
    FROM gold."FactHeadcount"
    WHERE date_sk = (SELECT MAX(date_sk) FROM gold."FactHeadcount")
),
demissoes_atual AS (
    SELECT COUNT(DISTINCT employee_id) as total_dem
    FROM gold."DimEmployee"
    WHERE TO_CHAR(termination_date, 'YYYYMM') = (
        SELECT SUBSTRING(CAST(MAX(date_sk) AS VARCHAR), 1, 6) FROM gold."FactHeadcount"
    )
)
SELECT 
    h.total_hc as active_headcount,
    d.total_dem as monthly_terminations,
    ROUND((d.total_dem::numeric / NULLIF(h.total_hc, 0)::numeric) * 100, 2) as turnover_rate_percentage
FROM hc_atual h, demissoes_atual d;