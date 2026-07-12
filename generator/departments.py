def generate_departments(meta):
    names = ["Engineering", "Data & Analytics", "Product", "Sales", "Marketing", "Finance", "Human Resources", "Operations", "Customer Success", "Legal", "IT", "Procurement", "Strategy", "Risk", "Quality", "Support", "Logistics", "Security", "Communications", "Research"]
    return [{"department_id": i + 1, "department_name": name, "cost_center_id": (i % 10) + 1, **meta} for i, name in enumerate(names)]

