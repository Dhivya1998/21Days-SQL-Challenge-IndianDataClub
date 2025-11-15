## Practice Questions:
-- 1. Find all weeks in services_weekly where no special event occurred.
select * from services_weekly where event is NULL or event = '' or lower(event)= 'none' ;

-- 2. Count how many records have null or empty event values.
select count(*) from services_weekly where event is null or event = '' or lower(event)= 'none' ;

-- 3. List all services that had at least one week with a special event.
select distinct service from services_weekly where event is not null or event != '' or lower(event) != 'none' ;

/* ## Daily Challenge:
**Question:** Analyze the event impact by comparing weeks with events vs weeks without events.
Show: event status ('With Event' or 'No Event'), count of weeks, average patient satisfaction,
and average staff morale. Order by average patient satisfaction descending. */

select
		service,
		case
			when event is NULL or event = '' or lower(event)= 'none' then 'No Event' else 'With Event'
		end as event_status,
		count(*) as count_of_weeks,
		avg(patient_satisfaction) as avg_patient_satisfaction,
		avg(staff_morale) as avg_staff_morale
	from services_weekly
	group by 
		service,
		case
			when event is NULL or event = '' or lower(event)= 'none' then 'No Event' else 'With Event'
		end
	order by avg_patient_satisfaction desc;