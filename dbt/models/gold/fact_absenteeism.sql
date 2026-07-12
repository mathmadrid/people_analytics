select a.absence_sk as absenteeism_sk, to_char(a.absence_date, 'YYYYMMDD')::integer as date_sk,
  e.employee_sk, d.department_sk, p.position_sk, mg.manager_sk, l.location_sk, c.cost_center_sk,
  at.absence_type_sk, a.absence_hours, a.is_paid, 1 as absence_count
from {{ ref('sl_absences') }} a
join {{ ref('sl_employees_scd') }} e on a.employee_id = e.employee_id and a.absence_date between e.effective_start_date and e.effective_end_date
join {{ ref('dim_department') }} d on e.department_id = d.department_id
join {{ ref('dim_position') }} p on e.position_id = p.position_id
left join {{ ref('dim_manager') }} mg on e.manager_id = mg.manager_id
join {{ ref('dim_location') }} l on e.location_id = l.location_id
join {{ ref('dim_cost_center') }} c on e.cost_center_id = c.cost_center_id
join {{ ref('dim_absence_type') }} at on a.absence_type = at.absence_type

