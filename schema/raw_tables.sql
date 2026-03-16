CREATE TABLE IF NOT EXISTS raw_candidates (
    candidate_id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    source TEXT NOT NULL,
    profile_create_date DATE NOT NULL
);

