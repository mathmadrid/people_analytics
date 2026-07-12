import os
from datetime import date
from uuid import uuid4

from dotenv import load_dotenv
from sqlalchemy import create_engine

load_dotenv()

SOURCE_SYSTEM = "hr_erp_simulator"

def batch_metadata() -> dict:
    return {"ingestion_date": __import__("datetime").datetime.now(__import__("datetime").timezone.utc), "source_system": SOURCE_SYSTEM, "batch_id": str(uuid4())}

def get_engine():
    user = os.getenv("POSTGRES_USER", "people_admin")
    password = os.getenv("POSTGRES_PASSWORD", "people_admin_change_me")
    host = os.getenv("POSTGRES_HOST", "localhost")
    port = os.getenv("POSTGRES_PORT", "5432")
    database = os.getenv("POSTGRES_DB", "people_analytics")
    return create_engine(f"postgresql+psycopg2://{user}:{password}@{host}:{port}/{database}", pool_pre_ping=True)

def months_between(start: date, end: date):
    cursor = date(start.year, start.month, 1)
    while cursor <= end:
        yield cursor
        cursor = date(cursor.year + (cursor.month == 12), 1 if cursor.month == 12 else cursor.month + 1, 1)

