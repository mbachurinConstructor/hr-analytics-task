-- raw candidates
INSERT INTO raw_candidates (full_name, source, profile_created_date) VALUES
('Alice Johnson',   'LinkedIn',    '2024-01-05'),
('Bob Smith',       'Referral',    '2024-01-10'),
('Carol White',     'Career Page', '2024-01-15'),
('David Brown',     'LinkedIn',    '2024-02-01'),
('Eva Martinez',    'Referral',    '2024-02-10'),
('Frank Lee',       'Career Page', '2024-02-20'),
('Grace Kim',       'LinkedIn',    '2024-03-01'),
('Henry Wilson',    'Referral',    '2024-03-05'),
('Iris Chen',       'Career Page', '2024-03-15'),
('James Taylor',    'LinkedIn',    '2024-04-01'),
('Karen Davis',     'Referral',    '2024-04-10'),
('Leo Garcia',      'Career Page', '2024-04-20'),
('Mia Anderson',    'LinkedIn',    '2024-05-01'),
('Noah Thompson',   'Referral',    '2024-05-10'),
('Olivia Harris',   'Career Page', '2024-05-20');


-- raw applications
INSERT INTO raw_applications (candidate_id, role_level, applied_date, decision_date, expected_salary) VALUES
(1,  'Junior',    '2024-01-10', '2024-02-15', 45000),
(2,  'Senior',    '2024-01-15', '2024-03-01', 85000),
(3,  'Executive', '2024-01-20', '2024-03-10', 130000),
(4,  'Junior',    '2024-02-05', '2024-03-20', 47000),
(5,  'Senior',    '2024-02-15', '2024-04-01', 90000),
(6,  'Junior',    '2024-02-25', NULL,          48000),
(7,  'Senior',    '2024-03-05', '2024-04-15', 88000),
(8,  'Executive', '2024-03-10', '2024-05-01', 140000),
(9,  'Junior',    '2024-03-20', NULL,          46000),
(10, 'Senior',    '2024-04-05', '2024-05-10', 92000),
(11, 'Junior',    '2024-04-12', '2024-05-20', 44000),
(12, 'Executive', '2024-04-18', NULL,          135000),
(13, 'Senior',    '2024-05-02', '2024-06-10', 87000),
(14, 'Junior',    '2024-05-12', NULL,          45000),
(15, 'Senior',    '2024-05-22', '2024-07-01', 91000),
(1,  'Senior',    '2024-06-01', '2024-07-15', 86000),
(3,  'Junior',    '2024-06-10', NULL,          43000),
(5,  'Executive', '2024-06-20', '2024-08-01', 145000),
(7,  'Junior',    '2024-07-01', NULL,          47000),
(9,  'Senior',    '2024-07-10', '2024-08-20', 89000);


-- raw interviews
INSERT INTO raw_interviews (app_id, interview_date, outcome) VALUES
(1,  '2024-01-20', 'Passed'),
(1,  '2024-02-01', 'Passed'),
(2,  '2024-01-25', 'Passed'),
(2,  '2024-02-10', 'Passed'),
(3,  '2024-02-01', 'Passed'),
(3,  '2024-02-20', 'Rejected'),
(4,  '2024-02-15', 'Passed'),
(4,  '2024-03-01', 'Passed'),
(5,  '2024-02-25', 'Passed'),
(5,  '2024-03-10', 'No Show'),
(5,  '2024-03-15', 'Passed'),
(6,  '2024-03-10', 'Passed'),
(7,  '2024-03-15', 'Passed'),
(7,  '2024-04-01', 'Passed'),
(8,  '2024-03-20', 'Passed'),
(8,  '2024-04-10', 'Passed'),
(9,  '2024-04-01', 'Passed'),
(10, '2024-04-15', 'Passed'),
(10, '2024-04-25', 'Rejected'),
(11, '2024-04-20', 'Passed'),
(11, '2024-05-01', 'Passed'),
(12, '2024-05-01', 'Passed'),
(13, '2024-05-10', 'Passed'),
(13, '2024-05-25', 'Passed'),
(14, '2024-05-20', 'No Show'),
(15, '2024-06-01', 'Passed'),
(16, '2024-06-10', 'Passed'),
(17, '2024-06-20', 'Passed'),
(18, '2024-07-01', 'Passed'),
(19, '2024-07-10', 'Rejected'),
(20, '2024-07-20', 'Passed'),
(2,  '2024-01-25', 'Passed'),  -- duplicate: same app_id, date, outcome
(4,  '2024-01-15', 'Passed'); -- data quality vialation, interview_date before applied_date

