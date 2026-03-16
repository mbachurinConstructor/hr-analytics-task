CREATE TABLE IF NOT EXISTS raw_candidates (
    candidate_id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    source TEXT NOT NULL,
    profile_create_date DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS raw_applications (
    app_id SERIAL PRIMARY KEY,
    candidate_id INTEGER REFERENCES raw_candidates(candidate_id),
    role_level TEXT NOT NULL CHECK (role_level IN ('Junior', 'Senior', 'Executive')),
    applied_date DATE NOT NULL,
    decision_date DATE,
    expected_salary NUMERIC
);

CREATE TABLE IF NOT EXISTS raw_interviews(
    interview_id SERIAL PRIMARY KEY,
    app_id INTEGER REFERENCES raw_applications(app_id),
    interview_date DATE NOT NULL,
    outcome TEXT NOT NULL CHECK (outcome IN ('Passed', 'Rejected', 'No Show'))
);