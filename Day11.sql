### Practice Questions:
-- 1. List all unique services in the patients table.
select distinct service from patients;

-- 2. Find all unique staff roles in the hospital.
select distinct role from staff;

-- 3. Get distinct months from the services_weekly table.
select distinct month from services_weekly;

/* ### Daily Challenge:
**Question:** Find all unique combinations of service and event type from the services_weekly 
table where events are not null or none, along with the count of occurrences for each combination.
Order by count descending. */

SELECT  
    service, 
    event, 
    COUNT(*) AS event_count
FROM services_weekly
WHERE event != 'none' AND event IS NOT NULL
GROUP BY service, event
ORDER BY event_count DESC;

