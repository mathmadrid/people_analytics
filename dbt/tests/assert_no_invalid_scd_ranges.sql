select * from {{ ref('sl_employees_scd') }} where effective_end_date < effective_start_date

