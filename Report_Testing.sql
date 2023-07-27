-- HR Analytics --

-- Purpose of using SQL is to test the PowerBI dashboard which we have used

-- 1. Functional validation - Testing each feature as per the requirement. Verifying all the filters and action filters on 
-- the report work as per requirement.

-- 2. Data validation - Checking accuracy and quality of data (for the calculated measures as well as the visualizations 
--     performed) from the PowerBI report.

-- 3. Text Document - Create a Test Document which which will contain screenshots and queries used to test the report. 
-- This should be sent to our manager or the client to show that we have validated our report.

-- Test Queries as per the report created are as follows: 

-- 1. Find Total Employees
-- 2. Overall Attrition Count
-- 3. Attrition Rate
-- 4. Active Employees
-- 5. Median Age
-- 6. Attrition by department :
--     Print both Count and percentage
-- 7. Total Count of Employees based on age band
-- 8. Job satisfaction Rating Count based on Job roles
-- 9. Field-wise Attrition Count.
-- 10. Employee Attrition by Gender and Age Bands.








-- 1. Find Total Employees

select count(*) from hr_data;

select sum(`Employee Count`)
from hr_data;

-- 2. Overall Attrition Count

select count(attrition) from hr_data
where `Attrition` = 'Yes';

-- 3. Active Employees


select count(*)
from hr_data
where `Attrition` = "No"

-- 4. Median Age



-- 5. Attrition Rate 

--               METHOD 1     ----    Using Count and Case statement

select
    (COUNT(Case when `Attrition` = "Yes" THEN 1 END) / SUM(`Employee Count`))*100 As 'Attrition_Percent'
from hr_data;  -- Result of this query matches with the dashboard


-- We can also replace the "SUM(`Employee Count`)" in the above query with " count(*)" ... gives same result

select
    (COUNT(Case when `Attrition` = "Yes" THEN 1 END) / COUNT(*))*100 As 'Attrition_Percent'
from hr_data;


--               METHOD 2    ----     Using CTE (Common Table Expressions)


WITH query1 AS (
    SELECT COUNT(*) AS "attrition_count" FROM hr_data WHERE `Attrition` = 'Yes'
),
query2 AS (
    SELECT COUNT(*) AS "total_employees" FROM hr_data
)
SELECT (attrition_count/total_employees)*100 AS result
FROM query1, query2;


-- Result from this query matches with the Power Bi report

-- 6. Attrition by department :
--     Print both Count and percentage

select `Department`,count(*)
from hr_data
where `Attrition` = 'Yes'
group by `Department`;

-- 7. Total Count of Employees based on age band

select `CF_age band` , `Gender` , count(*)
from hr_data
group by `CF_age band`, `Gender`
order by `CF_age band`;

-- 8. Job satisfaction Rating Count based on Job roles

select `Job Role` , `Job Satisfaction` , count(`Job Satisfaction`)
from hr_data
group by `Job Role` , `Job Satisfaction`
order by `Job Role`;

-- 9. Field-wise Attrition Count.

select `Education Field` , count(`Attrition`) as "Attrition_count"
from hr_data
where `Attrition` = 'Yes'
group by `Education Field`
order by Attrition_count desc;


-- 10. Employee Attrition by Gender and Age Bands.

select `CF_age band` , `Gender` , count(`Attrition`) as "Attrition_count"
from hr_data
where `Attrition` = "Yes"
group by `CF_age band` , `Gender`
order by `CF_age band`;


-- 10.1 -- Filtering based on slicer value = "Bachelor's Degree"

select `CF_age band` , `Gender` , count(`Attrition`) as "Attrition_count"
from hr_data
where `Attrition` = "Yes" and `Education` = "Bachelor's Degree"
group by `CF_age band` , `Gender`
order by `CF_age band`;


-- 1.1 Find Total Employees by slicer values (Education field)

select count(*)
from hr_data
where `Education` = "Bachelor's Degree"

-- We can verify this matches with our PowerBI dashboard when we filter is using the "Bachelor's Degree slicer"

-- Similary we can do this by altering our values to ('Associate's Degree' , 'High School' , 'Master's Degreee' , 'Doctoral Degree')

-- 2.1 Attrition Count by slicer values

select count(*) from hr_data
where `Attrition` = 'Yes' and `Education` = "Bachelor's Degree";

-- Similary we can do this by altering our values to ('Associate's Degree' , 'High School' , 'Master's Degreee' , 'Doctoral Degree')


