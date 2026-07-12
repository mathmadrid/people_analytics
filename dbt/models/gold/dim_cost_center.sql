select cost_center_sk, cost_center_id, cost_center_code, cost_center_name from {{ ref('sl_cost_centers') }}

