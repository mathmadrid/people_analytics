with dates as (
  select generate_series(date '2024-07-01', date '2026-06-30', interval '1 day')::date as date_day
)
select to_char(date_day, 'YYYYMMDD')::integer as date_sk, date_day as full_date,
  extract(year from date_day)::integer as year, extract(quarter from date_day)::integer as quarter,
  extract(month from date_day)::integer as month_number, to_char(date_day, 'Month') as month_name,
  extract(isodow from date_day)::integer as day_of_week, to_char(date_day, 'Day') as day_name,
  (extract(isodow from date_day) in (6,7)) as is_weekend
from dates

