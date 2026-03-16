-- identify logical data quality violations and log them to dq_alerts, this table is to be used
-- as audit log book, it flags it so flags it so user could know what to
-- exclude or investigate manually

CREATE TABLE dq_alerts (
    alert_id      SERIAL PRIMARY KEY,
    check_name    TEXT NOT NULL,        -- for example interview_before_applied_date
    entity        TEXT NOT NULL,        -- which table bad record is from
    entity_id     INTEGER NOT NULL,     -- the actual ID of row
    message       TEXT NOT NULL,        -- description
    created_at    TIMESTAMP DEFAULT NOW()
);

INSERT INTO dq_alerts (check_name, entity, entity_id, message)
SELECT
    'interview_before_applied_date',
    'raw_interviews',
    i.interview_id,
    'Interview ' || i.interview_id || ' on ' || i.interview_date || ' is before applied_date ' || a.applied_date || ' for app ' || a.app_id
FROM raw_interviews i
JOIN raw_applications a ON i.app_id = a.app_id
WHERE i.interview_date < a.applied_date;
