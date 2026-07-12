with ranked as (
  select h.*, row_number() over (partition by history_id order by ingestion_date desc) as rn
  from {{ ref('br_employment_history') }} h
), valid as (
  select r.*, e.employee_number, e.full_name, e.email, e.birth_date, initcap(e.gender) as gender, e.hire_date, e.termination_date
  from ranked r join {{ ref('br_employees') }} e on r.employee_id = e.employee_id
  join {{ ref('sl_departments') }} d on r.department_id = d.department_id
  join {{ ref('sl_positions') }} p on r.position_id = p.position_id
  join {{ ref('sl_locations') }} l on r.location_id = l.location_id
  where rn = 1 and r.effective_end_date >= r.effective_start_date
)
select {{ pa_surrogate_key(['employee_id', 'effective_start_date']) }} as employee_sk,
  employee_id, employee_number, full_name, email, birth_date, gender, hire_date, termination_date,
  department_id, position_id, manager_id, location_id, cost_center_id, initcap(employment_type) as employment_type,
  status, change_reason, effective_start_date, effective_end_date,
  (effective_end_date = termination_date or (termination_date is null and effective_end_date = date '2026-06-30')) as is_current
from valid

