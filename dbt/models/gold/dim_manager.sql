select manager_sk, manager_id, manager_name, manager_email from {{ ref('sl_managers') }}

