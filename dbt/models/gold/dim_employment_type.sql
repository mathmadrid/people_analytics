select {{ pa_surrogate_key(['employment_type']) }} as employment_type_sk, employment_type
from (select distinct employment_type from {{ ref('sl_employees_scd') }}) x

