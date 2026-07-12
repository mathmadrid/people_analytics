select department_sk, department_id, department_name, cost_center_id from {{ ref('sl_departments') }}

