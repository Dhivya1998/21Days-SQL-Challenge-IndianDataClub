### Practice Questions:
-- 1. Show each patient with their service's average satisfaction as an additional column.
SELECT
  p.patient_id,
  p.name,
  p.service,
  p.satisfaction AS patient_satisfaction,
  s.avg_satisfaction
FROM patients p
LEFT JOIN (
  SELECT service, AVG(patient_satisfaction) AS avg_satisfaction
  FROM services_weekly
  GROUP BY service
) s
  ON p.service = s.service;
-- 2. Create a derived table of service statistics and query from it.
SELECT
    s.service,
    s.total_patients,
    s.avg_patient_satisfaction,
    s.total_refusals
FROM (
        SELECT 
            service,
            SUM(patients_admitted) AS total_patients,
            AVG(patient_satisfaction) AS avg_patient_satisfaction,
            SUM(patients_refused) AS total_refusals
        FROM services_weekly
        GROUP BY service
     ) s;


-- 3. Display staff with their service's total patient count as a calculated field.
SELECT
    st.staff_id,
    st.staff_name,
    st.service,
    totals.total_patients AS service_total_patients
FROM staff st
LEFT JOIN (
        SELECT 
            service,
            SUM(patients_admitted) AS total_patients
        FROM services_weekly
        GROUP BY service
     ) totals
ON st.service = totals.service;


/* ### Daily Challenge:
**Question:** Create a report showing each service with: service name,
total patients admitted, the difference between their total admissions and
the average admissions across all services, and a rank indicator 
('Above Average', 'Average', 'Below Average'). Order by total patients admitted descending. */

SELECT 
    st.service,
    st.total_patients,
    (st.total_patients - oa.avg_patients) AS difference_from_avg,
    CASE
        WHEN st.total_patients > oa.avg_patients THEN 'Above Average'
        WHEN st.total_patients = oa.avg_patients THEN 'Average'
        ELSE 'Below Average'
    END AS rank_indicator
FROM 
    (
        SELECT 
            service,
            SUM(patients_admitted) AS total_patients
        FROM services_weekly
        GROUP BY service
    ) st
CROSS JOIN 
    (
        SELECT 
            AVG(total_patients) AS avg_patients
        FROM 
            (
                SELECT 
                    service,
                    SUM(patients_admitted) AS total_patients
                FROM services_weekly
                GROUP BY service
            ) x
    ) oa
ORDER BY st.total_patients DESC;

