select {{ pa_surrogate_key(['absence_type']) }} as absence_type_sk, absence_type
from (select distinct absence_type from {{ ref('sl_absences') }}) x

