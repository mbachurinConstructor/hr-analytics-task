-- build dm_hiring_process data mart
-- gets data from raw_candidates, raw_applications, clean_interviews

CREATE TABLE dm_hiring_process AS
    SELECT
        a.app_id,
        c.full_name,
        c.source,
        a.role_level,
        a.applied_date,
        a.decision_date,   -- null if process still active

        (a.decision_date - a.applied_date) AS time_to_decision_days,

        a.expected_salary,

        COUNT(CASE WHEN i.outcome = 'Passed' THEN 1 END) AS passed_interviews

    FROM raw_applications a
    JOIN raw_candidates c
        ON a.candidate_id = c.candidate_id
    LEFT JOIN clean_interviews i
        ON a.app_id = i.app_id
    GROUP BY
        a.app_id,
        c.full_name,
        c.source,
        a.role_level,
        a.applied_date,
        a.decision_date,
        a.expected_salary;


