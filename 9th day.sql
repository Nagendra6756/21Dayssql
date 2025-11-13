----------------------Day 9 (12/11): Date Functions

-----------------1. Extract the year from all patient arrival dates.
select year(arrival_date) as year FROM patients


---------------2. Calculate the length of stay for each patient (departure_date - arrival_date).
select patient_id,departure_date,arrival_date,
DATEDIFF(day,arrival_date,departure_Date) as days
from patients
order by days desc


----------------3. Find all patients who arrived in a specific month.
select patient_id,name,datename(month,arrival_date) as month
from patients


---### Daily Challenge:

--------**Question:** Calculate the average length of stay (in days) for each service, showing only services where the average stay is more than 7 days. 
-----Also show the count of patients and order by average stay descending.


select 
service,
avg(datediff(day,arrival_date,departure_Date)) as length,
count(*) as patients_count
from patients
group by service
having avg(datediff(day,arrival_date,departure_Date))>7