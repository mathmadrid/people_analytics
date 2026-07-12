select {{ pa_surrogate_key(['gender']) }} as gender_sk, gender
from (select distinct gender from {{ ref('sl_employees_scd') }}) x

