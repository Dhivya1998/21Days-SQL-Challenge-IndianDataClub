### Practice Questions:
-- 1. Calculate running total of patients admitted by week for each service.
select
	week,
    service,
    patients_admitted,
    sum(patients_admitted) over(partition by service order by week) as running_total
from services_weekly;

-- 2. Find the moving average of patient satisfaction over 4-week periods.
select 
		week,
        service,
        patient_satisfaction,
        round(avg(patient_satisfaction) over(partition by service order by week rows between 3 preceding and 0 preceding),2) as avg_rolling
from services_weekly;

-- 3. Show cumulative patient refusals by week across all services.
select 
	week,
    patients_refused,
    sum(patients_refused) over(order by week) as cumulative_of_patient_refusals
from services_weekly;

/* ### Daily Challenge:
**Question:** Create a trend analysis showing for each service and week:
week number, patients_admitted, running total of patients admitted (cumulative),
3-week moving average of patient satisfaction (current week and 2 prior weeks),
and the difference between current week admissions and the service average.
Filter for weeks 10-20 only.*/

select
	service,
	week as week_number,
    patients_admitted,
    sum(patients_admitted) over(partition by service order by week) as running_total_of_patients_admitted,
    round(avg(patient_satisfaction) over(partition by service order by week rows between 2 preceding and 0 preceding),2) as moving_avg_satisfaction,
    patients_admitted - round(avg(patients_admitted) over (partition by service),2) as diff_from_avg_service
from services_weekly
where week between 10 and 20
order by service, week;

