def generate_locations(meta):
    cities = [("São Paulo Office", "São Paulo", "SP"), ("Rio de Janeiro Office", "Rio de Janeiro", "RJ"), ("Belo Horizonte Office", "Belo Horizonte", "MG"), ("Curitiba Office", "Curitiba", "PR"), ("Remote", "São Paulo", "SP")]
    return [{"location_id": i + 1, "location_name": x[0], "city": x[1], "state": x[2], "country": "Brazil", **meta} for i, x in enumerate(cities)]

