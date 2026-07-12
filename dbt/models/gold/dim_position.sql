select position_sk, position_id, position_title, job_level from {{ ref('sl_positions') }}

