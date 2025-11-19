### Practice Questions:
-- 1. Join patients, staff, and staff_schedule to show patient service and staff availability.
select
	*
from patients p join staff s on p.service = s.service
	join staff_schedule ss on s.staff_id = ss.staff_id;
    
-- 2. Combine services_weekly with staff and staff_schedule for comprehensive service analysis.
select
	*
from services_weekly sw join staff s on sw.service = s.service
	join staff_schedule ss on s.staff_id = ss.staff_id;

-- 3. Create a multi-table report showing patient admissions with staff information.
select
	*
from patients p join staff s on p.service = s.service
	join staff_schedule ss on s.staff_id = ss.staff_id;

/* ### Daily Challenge:
**Question:** Create a comprehensive service analysis report for week 20 showing:
service name, total patients admitted that week, total patients refused, average patient satisfaction,
count of staff assigned to service, and count of staff present that week. Order by patients admitted descending. */

select
	sw.service,
    sum(sw.patients_admitted) as total_patients_admitted,
    sum(sw.patients_refused) as total_patients_refused,
    round(avg(sw.patient_satisfaction),2) as avg_satisfaction,
    count(s.staff_id) as total_staff,
    count(case when ss.present = 1 then 1 end) as total_staff_present
from services_weekly sw 
join staff s 
	on sw.service = s.service
join staff_schedule ss 
	on s.staff_id = ss.staff_id
where sw.week = 20 and ss.week = 20
group by sw.service
order by total_patients_admitted desc;

	


