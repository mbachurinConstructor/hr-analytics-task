# HR Analytics Pipeline

An SQL data engineering project simulating a hiring analytics pipeline.

## Stack
- PostgreSQL 15
- Docker / Docker Compose

## Quick Start

```bash
git clone https://github.com/mbachurinConstructor/hr-analytics-task.git
cd hr-analytics-task
docker-compose up -d
```

The database bootstraps automatically on first startup. All tables, seed data, ETL scripts, and the data mart are created in order.

Connect to inspect:
```bash
docker exec -it hr-analytics-task-postgres-1 psql -U admin -d hr_analytics
```

## Project Structure

```
hr-analytics-task/
├── schema/
│   └── raw_tables.sql              # Raw ATS tables (candidates, applications, interviews)
├── data/
│   └── seed.sql                    # Sample data with intentional duplicates and DQ violations
├── etl/
│   ├── 01_dedup.sql                # Deduplication → clean_interviews
│   ├── 02_dq_checks.sql            # Data quality checks → dq_alerts
│   └── 03_dm_hiring.sql            # Data mart → dm_hiring_process
├── analytics/
│   ├── 01_monthly_pipeline.sql     # Monthly active application count
│   └── 02_cumulative_hires.sql     # Cumulative hires by source
├── bash_scripts/
│   ├── open_db_terminal.sh         # connect to db terminal in one command
│   ├── run_monthly_pipeline.sh     # Run monthly pipeline query
│   └── run_cumulative_hires.sh     # Run cumulative hires query
└── docker-compose.yml
```

## Pipeline Overview

```
raw_candidates   ─┐
raw_applications  ├──► ETL ──► dm_hiring_process ──► Analytics
raw_interviews   ─┘
```

## ETL Design Decisions

### Deduplication — `etl/01_dedup.sql`
Duplicates in `raw_interviews` are identified using `ROW_NUMBER()` partitioned by `(app_id, interview_date, outcome)`. When duplicates exist, the row with the lowest `interview_id` is kept. Results are written to a clean `clean_interviews` table.

### Data Quality — `etl/02_dq_checks.sql`
Violations are written to a `dq_alerts` table with `entity` and `entity_id` columns referencing the offending row directly, making every alert actionable. Three checks are performed:

- Interview date occurring before the application's `applied_date`
- Decision date occurring before the `applied_date`
- Applications referencing a `candidate_id` that doesn't exist in `raw_candidates`

### Data Mart — `etl/03_dm_hiring.sql`
`dm_hiring_process` has one row per application. Key design choices:

- `LEFT JOIN` on `clean_interviews` preserves applications that have no interviews yet
- `time_to_decision_days` is NULL for active applications (no `decision_date` yet)
- `passed_interviews` uses `COUNT(CASE WHEN outcome = 'Passed' THEN 1 END)` to count only successful interview stages, ignoring Rejected and No Show outcomes

## Analytical Queries

### Monthly Active Pipeline
Uses `generate_series()` to build a date spine from the earliest application date to today. An application is counted as active in a month if that month falls between its `applied_date` and `COALESCE(decision_date, CURRENT_DATE)`. This ensures active applications (no `decision_date`) remain in the pipeline until today.

### Cumulative Hires by Source
A hire is defined as a closed application (`decision_date IS NOT NULL`) with at least one Passed interview. Monthly hire counts are calculated per source, then a running total is computed using `SUM() OVER (PARTITION BY source ORDER BY month)`.

## Seed Data

The seed data contains two deliberate anomalies to validate the ETL:

- **Duplicate**: an interview row with the same `app_id`, `interview_date`, and `outcome` entered twice — caught and removed by `01_dedup.sql`
- **DQ Violation**: an `interview_date` that predates the `applied_date` of its linked application — caught and logged by `02_dq_checks.sql`

## Running Analytics

Run each analytical query independently:

```bash
# Monthly active pipeline
bash bash_scripts/run_monthly_pipeline.sh

# Cumulative hires by source
bash bash_scripts/run_cumulative_hires.sh
```
