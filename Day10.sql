### Practice Questions:
-- 1. Categorise patients as 'High', 'Medium', or 'Low' satisfaction based on their scores.
select 
	patient_id,
    satisfaction,
    CASE 
		when satisfaction >= 85 then 'High'
        when satisfaction between 75 and 84 then 'Medium'
        else 'Low'
	end as satisfaction_category
from patients;

-- 2. Label staff roles as 'Medical' or 'Support' based on role type.
select
		staff_id,
        staff_name,
        Case
			when role = 'doctor' then 'medical'
            else 'support'
		end as staff_label
from staff;

-- 3. Create age groups for patients (0-18, 19-40, 41-65, 65+).
select
	patient_id,
    name,
    age,
    case
		when age between 0 and 18 then 'Teens'
        when age between 19 and 40 then 'Young Adults'
        when age between 41 and 65 then 'Middle aged Adults'
        else 'Seniors'
	end as age_category
from patients;


/* ### Daily Challenge:
**Question:** Create a service performance report showing service name, total patients admitted, 
and a performance category based on the following: 'Excellent' if avg satisfaction >= 85,
'Good' if >= 75, 'Fair' if >= 65, otherwise 'Needs Improvement'. Order by average satisfaction descending.*/

select
	service,
    sum(patients_admitted) as total_patients_admitted,
    round(avg(patient_satisfaction),2) as avg_satisfaction,
    case
		when round(avg(patient_satisfaction),2)  >= 85 then 'Excellent'
        when round(avg(patient_satisfaction),2)  >= 75 then 'Good'
        when round(avg(patient_satisfaction),2)  >= 65 then 'Fair'
        else 'Needs Improvement'
	end as performance_category
from services_weekly
group by service
order by avg(patient_satisfaction) desc;





