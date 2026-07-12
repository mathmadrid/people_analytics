select location_sk, location_id, location_name, city, state, country from {{ ref('sl_locations') }}

