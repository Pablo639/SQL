/*------Handling dates------*/
SELECT job_posted_date
FROM job_postings_fact
LIMIT 10;

-- Date Funcions in SQL are used to perform operations on date and time values.
-- ::DATE converts to a date format by removing time portion.
-- AT TIME ZONE: Converts a timestamp to a specified time zone.
-- EXTRACT: Gets specific date parts (e-g-, year,month,day)

-- Hint: Use "::" for converting a value from one data type to another-
-- Example: SELECT '2024-02-01'::, '123'::INTEGER, '123.45'::FLOAT;

SELECT '2023-02-19'::DATE,
        '123'::INTEGER,
        'TRUE':: BOOLEAN,
        '3.14':: REAL;

/*------Convert to DATE------ */

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE AS date
FROM
    job_postings_fact
LIMIT 10;

/*------Convert to TIME ZONE------ */
-- Converts timestamps between differen time zones

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time --We know it's EST since we know the origin of the data. It's not standard
FROM
    job_postings_fact
LIMIT 10;

/*------EXTRACT FUNCTION------ */
-- Extracts what we want from the date (year, month, day, etc.)

SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time, --We know it's EST since we know the origin of the data. It's not standard
    EXTRACT(MONTH FROM job_posted_date) AS month, -- Extracts the month from the date
    EXTRACT(YEAR FROM job_posted_date) AS year
FROM
    job_postings_fact
LIMIT 5;


-- make a analysis of job postings to month to month

SELECT
    COUNT(job_id) AS job_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    month
ORDER BY
    job_count DESC; -- ASC = ascending order, DESC = descending order



-- Find the average salary both yearly and hourly for job postings where posted
-- after June 1,2023. Group the results by schedule type:

SELECT
    ROUND(AVG(salary_year_avg),2) AS avg_yearly_salary,
    ROUND(AVG(salary_hour_avg),2) AS avg_hourly_salary,
    job_schedule_type AS schedule
FROM
    job_postings_fact
WHERE
    job_posted_date > '2023-06-01' AND 
    (salary_year_avg IS NOT NULL OR salary_hour_avg IS NOT NULL)
    
GROUP BY
    schedule
ORDER BY
    avg_yearly_salary ASC;

-- Count the number of job_postings for each month in 2023, adjusting the
-- job_posted_date to be in 'America/New_York' timezone. Group By and Order by the month

SELECT
    COUNT(job_id) AS job_count,
    EXTRACT(MONTH FROM(job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York')) AS month
    
FROM
    job_postings_fact
GROUP BY
    month
ORDER BY
    month ASC; 


-- With month names

SELECT
    TO_CHAR((job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York'), 'Month') AS month_name,
    COUNT(job_id) AS job_count
FROM
    job_postings_fact

GROUP BY
    TO_CHAR((job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York'), 'Month'),
    EXTRACT(MONTH FROM (job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York'))
ORDER BY
    EXTRACT(MONTH FROM (job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York'));

-- find companies that have posted jobs offering health insurance, where these postings were made in 
-- the second quearter of 2023.
SELECT
    job_title,
    company_dim.name AS company_name,
    COUNT(job_postings_fact.job_id) AS job_count,
    EXTRACT(quarter FROM job_posted_date) AS quarter
FROM
    job_postings_fact
LEFT JOIN 
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    EXTRACT(quarter FROM job_posted_date) = 2
    AND job_posted_date >= '2023-01-01'  -- Ensure we're only looking at 2023
    AND job_title LIKE '%health%insurance%'   -- Assuming this column exists for health insurance
GROUP BY
    company_dim.name, job_title, quarter
ORDER BY
    job_count DESC;
