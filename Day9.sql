### Practice Questions:
-- 1. Extract the year from all patient arrival dates.
select year(arrival_date) as arrival_year from patients;

-- 2. Calculate the length of stay for each patient (departure_date - arrival_date).
select
	*,
    datediff(departure_date,arrival_date) as length_of_stay
from patients;

-- 3. Find all patients who arrived in a specific month.
select
    month(arrival_date) as arrival_month,
    count(*) as total_patients
from patients
group by month(arrival_date)
having count(*) > 1
order by arrival_month;


/* ### Daily Challenge:
**Question:** Calculate the average length of stay (in days) for each service, 
showing only services where the average stay is more than 7 days. 
Also show the count of patients and order by average stay descending. */

select
	service,
    avg(datediff(departure_date,arrival_date)) as average_length_of_stay,
    count(patient_id) as patient_count
from patients
group by service
having avg(datediff(departure_date,arrival_date)) > 7
order by average_length_of_stay desc;
