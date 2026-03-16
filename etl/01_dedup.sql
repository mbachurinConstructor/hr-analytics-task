-- deduplicate raw_interviews and write clean records to clean_interviews

CREATE TABLE IF NOT EXISTS clean_interviews AS
    SELECT
        interview_id,
        app_id,
        interview_date,
        outcome
    FROM (
        SELECT *,
               ROW_NUMBER() OVER (
                   PARTITION BY app_id, interview_date, outcome
                   ORDER BY interview_id ASC
               ) AS rn
        FROM raw_interviews
    ) ranked
    WHERE rn = 1;