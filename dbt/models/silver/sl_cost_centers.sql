select distinct on (cost_center_id)
  cost_center_id, trim(cost_center_code) as cost_center_code, trim(cost_center_name) as cost_center_name,
  {{ pa_surrogate_key(['cost_center_id']) }} as cost_center_sk
from {{ ref('br_cost_centers') }} where cost_center_id is not null
order by cost_center_id, ingestion_date desc

