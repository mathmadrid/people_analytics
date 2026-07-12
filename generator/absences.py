from datetime import date, timedelta
import random

def generate_absences(employees, histories, meta, count=12000, start=date(2024, 7, 1), end=date(2026, 6, 30)):
    history_by_employee = {}
    for h in histories: history_by_employee.setdefault(h["employee_id"], []).append(h)
    active = [e for e in employees if e["hire_date"] <= end]
    types = [("Vacation", True), ("Medical Leave", True), ("Work Accident", True)]
    rows, absence_id = [], 1
    random.seed(42)
    while len(rows) < count:
        e = random.choice(active)
        lower, upper = max(start, e["hire_date"]), min(end, e["termination_date"] or end)
        if lower > upper: continue
        absence_date = lower + timedelta(days=random.randint(0, (upper - lower).days))
        absence_type, paid = random.choices(types, weights=[70, 25, 5])[0]
        rows.append({"absence_id": absence_id, "employee_id": e["employee_id"], "absence_date": absence_date, "absence_type": absence_type, "absence_hours": 8.0, "is_paid": paid, **meta})
        absence_id += 1
    return rows

