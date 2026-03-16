#!/bin/bash
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJECT_DIR"

docker exec hr-analytics-task-postgres-1 psql -U admin -d hr_analytics -c "
WITH monthly_hires AS (
    SELECT
        DATE_TRUNC('month', decision_date)::DATE AS month,
        source,
        COUNT(*) AS hires_this_month
    FROM dm_hiring_process
    WHERE decision_date IS NOT NULL AND passed_interviews > 0
    GROUP BY DATE_TRUNC('month', decision_date)::DATE, source
)

SELECT
    month,
    source,
    hires_this_month,
    SUM(hires_this_month) OVER (
        PARTITION BY source
        ORDER BY month
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_hires
FROM monthly_hires
ORDER BY source, month;

"