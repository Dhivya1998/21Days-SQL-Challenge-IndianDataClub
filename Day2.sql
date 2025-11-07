-- Single condition
SELECT * FROM patients WHERE age > 60;
-- Multiple conditions
SELECT * FROM patients
WHERE age > 60 AND service = 'Cardiology';
-- OR condition
SELECT * FROM patients
WHERE service = 'Emergency' OR service = 'Cardiology';
-- IN operator (cleaner than multiple ORs)
SELECT * FROM patients
WHERE service IN ('Emergency', 'Cardiology', 'Neurology');

-- Practice Questions:
-- 1. Find all patients who are older than 60 years.
select * from patients where age > 60;

-- 2. Retrieve all staff members who work in the 'Emergency' service.
select * from staff_schedule where service = 'Emergency';

-- 3. List all weeks where more than 100 patients requested admission in any service.
select * from services_weekly where patients_request > 100;

-- ### Daily Challenge:
-- Find all patients admitted to 'Surgery' service with a satisfaction score below 70,
-- showing their patient_id, name, age, and satisfaction score.
select patient_id, name, age, satisfaction as satisfaction_score from patients
where service = 'surgery' and satisfaction < 70;