### Practice Questions:
-- 1. Rank patients by satisfaction score within each service.
select 
	patient_id,
    name,
    service,
    satisfaction,
    rank() over(partition by service order by satisfaction desc) as rn
from patients;

-- 2. Assign row numbers to staff ordered by their name.
select
	staff_id,
    staff_name,
    role,
    service,
    row_number() over(order by staff_name) as rn
from staff;

-- 3. Rank services by total patients admitted.
SELECT
    service,
    total_patients_admitted,
    RANK() OVER(ORDER BY total_patients_admitted DESC) AS rk
FROM (
    SELECT
        service,
        SUM(patients_admitted) AS total_patients_admitted
    FROM services_weekly
    GROUP BY service
) AS service_totals;


/* ### Daily Challenge:
**Question:** For each service, rank the weeks by patient satisfaction score (highest first).
Show service, week, patient_satisfaction, patients_admitted, and the rank.
Include only the top 3 weeks per service. */

select
	*
from (
select
	service,
    week,
    patient_satisfaction,
    patients_admitted,
    rank() over(partition by service order by  patient_satisfaction desc) as rk
from services_weekly)a
where rk <=3;
	

