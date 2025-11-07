### Practice Questions:

-- 1. Count the total number of patients in the hospital.
select count(patient_id) as total_no_of_patients from patients;

-- 2. Calculate the average satisfaction score of all patients.
select avg(satisfaction) as avg_satisfaction_score from patients;

-- 3. Find the minimum and maximum age of patients.
select 
	min(age) as min_age,
	max(age) as max_age
from patients;


### Daily Challenge:

/* Calculate the total number of patients admitted, total patients refused, 
and the average patient satisfaction across all services and weeks. 
Round the average satisfaction to 2 decimal places.*/

select
	count(patients_admitted) as total_no_of_patients_admitted,
    count(patients_refused) as total_no_of_patients_refused,
    round(avg(patient_satisfaction),2) as avg_patient_satisfaction    
from services_weekly;





