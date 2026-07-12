select distinct on (position_id)
  position_id, trim(position_title) as position_title, trim(job_level) as job_level,
  initcap(trim(employment_type)) as employment_type, {{ pa_surrogate_key(['position_id']) }} as position_sk
from {{ ref('br_positions') }}
where position_id is not null
order by position_id, ingestion_date desc

