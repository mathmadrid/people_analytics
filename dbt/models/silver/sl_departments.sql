select distinct on (department_id)
  department_id, trim(department_name) as department_name, cost_center_id,
  {{ pa_surrogate_key(['department_id']) }} as department_sk
from {{ ref('br_departments') }}
where department_id is not null and nullif(trim(department_name), '') is not null
order by department_id, ingestion_date desc

