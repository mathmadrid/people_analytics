from datetime import date, timedelta
from faker import Faker

def generate_employees(meta, count=1500, as_of=date(2026, 6, 30)):
    fake = Faker("pt_BR")
    rows = []
    for employee_id in range(1, count + 1):
        hire_date = fake.date_between(date(2018, 1, 1), as_of - timedelta(days=30))
        terminated = employee_id % 11 == 0
        termination_date = fake.date_between(max(hire_date + timedelta(days=30), date(2024, 7, 1)), as_of) if terminated else None
        gender = "Female" if employee_id % 2 else "Male"
        rows.append({
            "employee_id": employee_id, 
            "employee_number": f"EMP{employee_id:06d}", 
            "full_name": fake.name_female() if gender == "Female" else fake.name_male(), 
            "email": f"employee{employee_id}@company.com", 
            "birth_date": fake.date_of_birth(minimum_age=22, maximum_age=62), # <- CORRIGIDO AQUI
            "gender": gender, 
            "hire_date": hire_date, 
            "termination_date": termination_date, 
            "department_id": (employee_id % 20) + 1, 
            "position_id": (employee_id % 10) + 1, 
            "manager_id": (employee_id % 120) + 1, 
            "location_id": (employee_id % 5) + 1, 
            "cost_center_id": (employee_id % 10) + 1, 
            "employment_type": "CLT" if employee_id % 8 else "Contractor", 
            "status": "Terminated" if terminated else "Active", 
            **meta
        })
    return rows