-- count active applications for every month
-- applicaiton is active in a month if that month is between applied_date and decision_date (or today if null)

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