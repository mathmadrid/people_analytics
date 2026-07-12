select distinct on (manager_id)
  manager_id, trim(manager_name) as manager_name, lower(trim(manager_email)) as manager_email,
  {{ pa_surrogate_key(['manager_id']) }} as manager_sk
from {{ ref('br_managers') }} where manager_id is not null
order by manager_id, ingestion_date desc

