with month_ends as (
  select (date_trunc('month', full_date) + interval '1 month - 1 day')::date as snapshot_date
  from {{ ref('dim_date') }} group by 1
)
select {{ pa_surrogate_key(['e.employee_sk', 'm.snapshot_date']) }} as headcount_sk,
  to_char(m.snapshot_date, 'YYYYMMDD')::integer as date_sk, e.employee_sk,
  d.department_sk, p.position_sk, mg.manager_sk, l.location_sk, c.cost_center_sk,
  et.employment_type_sk, g.gender_sk, 1 as headcount
from month_ends m join {{ ref('sl_employees_scd') }} e on m.snapshot_date between e.effective_start_date and e.effective_end_date
join {{ ref('dim_department') }} d on e.department_id = d.department_id
join {{ ref('dim_position') }} p on e.position_id = p.position_id
left join {{ ref('dim_manager') }} mg on e.manager_id = mg.manager_id
join {{ ref('dim_location') }} l on e.location_id = l.location_id
join {{ ref('dim_cost_center') }} c on e.cost_center_id = c.cost_center_id
join {{ ref('dim_employment_type') }} et on e.employment_type = et.employment_type
join {{ ref('dim_gender') }} g on e.gender = g.gender

