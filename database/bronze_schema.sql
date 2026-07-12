CREATE SCHEMA IF NOT EXISTS bronze;

CREATE TABLE IF NOT EXISTS bronze.departments (
  department_id integer NOT NULL, department_name text NOT NULL, cost_center_id integer NOT NULL,
  ingestion_date timestamptz NOT NULL, source_system text NOT NULL, batch_id uuid NOT NULL
);
CREATE TABLE IF NOT EXISTS bronze.positions (
  position_id integer NOT NULL, position_title text NOT NULL, job_level text NOT NULL,
  employment_type text NOT NULL, ingestion_date timestamptz NOT NULL, source_system text NOT NULL, batch_id uuid NOT NULL
);
CREATE TABLE IF NOT EXISTS bronze.locations (
  location_id integer NOT NULL, location_name text NOT NULL, city text NOT NULL, state text NOT NULL, country text NOT NULL,
  ingestion_date timestamptz NOT NULL, source_system text NOT NULL, batch_id uuid NOT NULL
);
CREATE TABLE IF NOT EXISTS bronze.cost_centers (
  cost_center_id integer NOT NULL, cost_center_code text NOT NULL, cost_center_name text NOT NULL,
  ingestion_date timestamptz NOT NULL, source_system text NOT NULL, batch_id uuid NOT NULL
);
CREATE TABLE IF NOT EXISTS bronze.managers (
  manager_id integer NOT NULL, manager_name text NOT NULL, manager_email text NOT NULL,
  ingestion_date timestamptz NOT NULL, source_system text NOT NULL, batch_id uuid NOT NULL
);
CREATE TABLE IF NOT EXISTS bronze.employees (
  employee_id integer NOT NULL, employee_number text NOT NULL, full_name text NOT NULL, email text NOT NULL,
  birth_date date NOT NULL, gender text NOT NULL, hire_date date NOT NULL, termination_date date,
  department_id integer NOT NULL, position_id integer NOT NULL, manager_id integer, location_id integer NOT NULL,
  cost_center_id integer NOT NULL, employment_type text NOT NULL, status text NOT NULL,
  ingestion_date timestamptz NOT NULL, source_system text NOT NULL, batch_id uuid NOT NULL
);
CREATE TABLE IF NOT EXISTS bronze.employment_history (
  history_id bigint NOT NULL, employee_id integer NOT NULL, effective_start_date date NOT NULL, effective_end_date date,
  department_id integer NOT NULL, position_id integer NOT NULL, manager_id integer, location_id integer NOT NULL,
  cost_center_id integer NOT NULL, employment_type text NOT NULL, status text NOT NULL, change_reason text NOT NULL,
  ingestion_date timestamptz NOT NULL, source_system text NOT NULL, batch_id uuid NOT NULL
);
CREATE TABLE IF NOT EXISTS bronze.absences (
  absence_id bigint NOT NULL, employee_id integer NOT NULL, absence_date date NOT NULL, absence_type text NOT NULL,
  absence_hours numeric(5,2) NOT NULL, is_paid boolean NOT NULL, ingestion_date timestamptz NOT NULL,
  source_system text NOT NULL, batch_id uuid NOT NULL
);

