#!/bin/bash
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJECT_DIR"

docker exec hr-analytics-task-postgres-1 psql -U admin -d hr_analytics -c "
WITH date_spine AS (
    SELECT generate_series(
           DATE_TRUNC('month', (SELECT MIN(applied_date) FROM dm_hiring_process)),
           DATE_TRUNC('month', CURRENT_DATE),
           INTERVAL '1 month'
           ) :: DATE AS month
)


SELECT ds.month, COUNT(dm.app_id) AS active_applications
FROM date_spine ds
LEFT JOIN dm_hiring_process dm
    ON ds.month >= DATE_TRUNC('month', dm.applied_date)
    AND ds.month <= DATE_TRUNC('month', COALESCE(dm.decision_date, CURRENT_DATE))
GROUP BY ds.month
ORDER BY ds.month;

"