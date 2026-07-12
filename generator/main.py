"""Generate a consistent synthetic HR dataset and load it into Bronze."""
from datetime import date
import pandas as pd
from sqlalchemy import text

from utils import batch_metadata, get_engine
from cost_centers import generate_cost_centers
from departments import generate_departments
from positions import generate_positions
from locations import generate_locations
from managers import generate_managers
from employees import generate_employees
from employment_history import generate_employment_history
from absences import generate_absences

AS_OF_DATE = date(2026, 6, 30)

def load(engine, table, rows):
    pd.DataFrame(rows).to_sql(table, engine, schema="bronze", if_exists="append", index=False, method="multi", chunksize=1000)

def main():
    meta = batch_metadata()
    engine = get_engine()
    cost_centers, departments = generate_cost_centers(meta), generate_departments(meta)
    positions, locations, managers = generate_positions(meta), generate_locations(meta), generate_managers(meta)
    employees = generate_employees(meta, as_of=AS_OF_DATE)
    history = generate_employment_history(employees, meta, AS_OF_DATE)
    absences = generate_absences(employees, history, meta)
    with engine.begin() as connection:
        for table in ["absences", "employment_history", "employees", "managers", "locations", "positions", "departments", "cost_centers"]:
            connection.execute(text(f"TRUNCATE TABLE bronze.{table}"))
    for table, rows in [("cost_centers", cost_centers), ("departments", departments), ("positions", positions), ("locations", locations), ("managers", managers), ("employees", employees), ("employment_history", history), ("absences", absences)]: load(engine, table, rows)
    print(f"Loaded batch {meta['batch_id']}: {len(employees)} employees, {len(history)} history rows, {len(absences)} absences.")

if __name__ == "__main__": main()
