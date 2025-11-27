### Practice Questions:
-- 1. Create a CTE to calculate service statistics, then query from it.
select 
	service,
    sum(available_beds) as total_beds,
    sum(patients_request) as total_patients_request,
    sum(patients_admitted) as total_patients_admitted,
    sum(patients_refused) as total_patients_refused,
    avg(patient_satisfaction) as avg_patients_satisfaction,
    avg(staff_morale) as avg_staff_morale,
    round(sum(patients_admitted)/nullif((sum(patients_admitted)+sum(patients_refused)),0),2) as admission_rate
from services_weekly
group by service;


-- 2. Use multiple CTEs to break down a complex query into logical steps.

with service_summary as(
select
	service,
    sum(patients_admitted) as total_patients,
    avg(patient_satisfaction) as avg_satisfaction
from services_weekly
group by service),

staff_summary as (
select 
	service,
    count(staff_id) as total_staff,
    round(avg(present),2) as avg_staff_presence
from staff_schedule
group by service),

patient_demographics as (
select
	service,
    count(patient_id) as patient_count,
    round(avg(age),2) as avg_age
from patients
group by service)

select 
	ss.service,
    ss.total_patients,
    ss.avg_satisfaction,
    st.total_staff,
    st.avg_staff_presence,
    pd.patient_count,
    pd.avg_age
from
	service_summary ss join staff_summary st on ss.service = st.service
join patient_demographics pd on st.service = pd.service;

-- 3. Build a CTE for staff utilization and join it with patient data.
with staff_utilization as (
select
	service,
	staff_id,
    sum(present) as total_present,
    count(week) as total_days_recorded,
    round(sum(present)/count(week),2) as utilization_rate
from staff_schedule
group by service, staff_id)

select
	su.service,
    count(distinct su.staff_id)  as total_staff,
    round(avg(utilization_rate),2) as avg_staff_utilization,
     count(p.patient_id) as total_patients,
    round(avg(satisfaction),2) as avg_patient_satisfaction    
from staff_utilization su join patients p on su.service = p.service
group by su.service;

/* ### Daily Challenge:
**Question:** Create a comprehensive hospital performance dashboard using CTEs. Calculate: 1)
Service-level metrics (total admissions, refusals, avg satisfaction), 2)
Staff metrics per service (total staff, avg weeks present), 3)
Patient demographics per service (avg age, count).
Then combine all three CTEs to create a final report showing service name,
all calculated metrics, and an overall performance score (weighted average of admission rate and satisfaction).
Order by performance score descending.*/

WITH Service_level_metrics AS (
    SELECT
        service,
        SUM(patients_admitted) AS total_admissions,
        SUM(patients_refused) AS total_refusals,
        ROUND(AVG(patient_satisfaction), 2) AS avg_satisfaction,

        -- Correct admission rate: admitted / (admitted + refused)
        ROUND(
            SUM(patients_admitted) /
            NULLIF(SUM(patients_admitted) + SUM(patients_refused), 0)
        , 2) AS admission_rate

    FROM services_weekly
    GROUP BY service
),

Staff_metrics AS (
    SELECT
        service,
        -- avg weeks present = (number of weeks staff was present / total weeks for the service)
        ROUND(SUM(present) * 1.0 / COUNT(DISTINCT week), 2) AS avg_weeks_present,
        COUNT(DISTINCT staff_id) AS total_staff
    FROM staff_schedule
    GROUP BY service
),

Patient_demographics AS (
    SELECT
        service,
        ROUND(AVG(age), 2) AS avg_age,
        COUNT(*) AS patient_count
    FROM patients
    GROUP BY service
)

SELECT 
    slm.service,
    slm.total_admissions,
    slm.total_refusals,
    slm.avg_satisfaction,
    slm.admission_rate,

    sm.total_staff,
    sm.avg_weeks_present,

    pd.avg_age,
    pd.patient_count,

    -- Weighted performance score
    ROUND(
        (slm.admission_rate * 0.6) +
        ((slm.avg_satisfaction / 100) * 0.4)
    , 2) AS overall_performance_score

FROM Service_level_metrics slm
JOIN Staff_metrics sm 
    ON slm.service = sm.service
JOIN Patient_demographics pd 
    ON slm.service = pd.service

ORDER BY overall_performance_score DESC;
