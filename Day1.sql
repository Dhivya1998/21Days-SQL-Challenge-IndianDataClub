SELECT * FROM hospital.patients;

SELECT name AS patient_name, age AS patient_age FROM patients;

-- 1. Retrieve all columns from the patients table.
SELECT * from patients;

-- 2. Select only the `patient_id`, `name`, and `age` columns from the `patients` table.
SELECT patient_id, name, age from patients;

-- 3. Display the first 10 records from the `services_weekly` table.
SELECT * from services_weekly LIMIT 10;

-- Question: List all unique hospital services available in the hospital.
Select distinct service from services_weekly;
