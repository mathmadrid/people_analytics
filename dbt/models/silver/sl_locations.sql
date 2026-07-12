select distinct on (location_id)
  location_id, trim(location_name) as location_name, trim(city) as city, upper(trim(state)) as state, trim(country) as country,
  {{ pa_surrogate_key(['location_id']) }} as location_sk
from {{ ref('br_locations') }} where location_id is not null
order by location_id, ingestion_date desc

