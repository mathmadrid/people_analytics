def generate_positions(meta):
    roles = [("Analyst", "Junior"), ("Analyst", "Pleno"), ("Analyst", "Senior"), ("Engineer", "Junior"), ("Engineer", "Pleno"), ("Engineer", "Senior"), ("Specialist", "Senior"), ("Coordinator", "Management"), ("Manager", "Management"), ("Director", "Executive")]
    rows = []
    for i, (role, level) in enumerate(roles, 1):
        rows.append({"position_id": i, "position_title": f"{role} {level}", "job_level": level, "employment_type": "CLT", **meta})
    return rows

