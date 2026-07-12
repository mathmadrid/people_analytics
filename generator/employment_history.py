from datetime import timedelta

def generate_employment_history(employees, meta, as_of):
    rows, history_id = [], 1
    for e in employees:
        end = e["termination_date"] or as_of
        events = [(e["hire_date"], "Hire", e["department_id"], e["position_id"], e["manager_id"])]
        # deterministic changes preserve valid, non-overlapping SCD intervals
        if (e["employee_id"] % 3 == 0) and e["hire_date"] + timedelta(days=180) < end:
            events.append((e["hire_date"] + timedelta(days=180), "Promotion", e["department_id"], min(e["position_id"] + 1, 10), e["manager_id"]))
        if (e["employee_id"] % 5 == 0) and e["hire_date"] + timedelta(days=365) < end:
            events.append((e["hire_date"] + timedelta(days=365), "Transfer", (e["department_id"] % 20) + 1, e["position_id"], (e["manager_id"] % 120) + 1))
        if (e["employee_id"] % 7 == 0) and e["hire_date"] + timedelta(days=270) < end:
            events.append((e["hire_date"] + timedelta(days=270), "Manager Change", e["department_id"], e["position_id"], (e["manager_id"] % 120) + 1))
        events.sort(key=lambda x: x[0])
        for idx, (start, reason, dept, pos, manager) in enumerate(events):
            effective_end = events[idx + 1][0] - timedelta(days=1) if idx + 1 < len(events) else end
            rows.append({"history_id": history_id, "employee_id": e["employee_id"], "effective_start_date": start, "effective_end_date": effective_end, "department_id": dept, "position_id": pos, "manager_id": manager, "location_id": e["location_id"], "cost_center_id": (dept - 1) % 10 + 1, "employment_type": e["employment_type"], "status": "Terminated" if e["termination_date"] and effective_end == e["termination_date"] else "Active", "change_reason": reason, **meta})
            history_id += 1
    return rows

