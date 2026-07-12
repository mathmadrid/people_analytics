def generate_cost_centers(meta):
    names = ["Corporate", "Technology", "Operations", "Commercial", "People", "Finance", "Legal", "Marketing", "Data", "Customer Success"]
    return [{"cost_center_id": i + 1, "cost_center_code": f"CC-{100 + i}", "cost_center_name": name, **meta} for i, name in enumerate(names)]

