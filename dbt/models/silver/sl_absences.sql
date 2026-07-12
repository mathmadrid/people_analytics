select distinct on (absence_id)
  absence_id, a.employee_id, a.absence_date, initcap(trim(a.absence_type)) as absence_type,
  a.absence_hours, a.is_paid, {{ pa_surrogate_key(['absence_id']) }} as absence_sk
from {{ ref('br_absences') }} a
join {{ ref('sl_employees_scd') }} e on a.employee_id = e.employee_id and a.absence_date between e.effective_start_date and e.effective_end_date
where a.absence_hours > 0 and a.absence_type in ('Vacation', 'Medical Leave', 'Work Accident')
order by absence_id, a.ingestion_date desc

