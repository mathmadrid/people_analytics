from faker import Faker

def generate_managers(meta, count=120):
    fake = Faker("pt_BR")
    return [{"manager_id": i, "manager_name": fake.name(), "manager_email": f"manager{i}@company.com", **meta} for i in range(1, count + 1)]

