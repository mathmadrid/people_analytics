select employee_sk, employee_id, employee_number, full_name, email, birth_date, hire_date, termination_date,
  effective_start_date, effective_end_date, is_current
from {{ ref('sl_employees_scd') }}

