SELECT
    job_title_short,
    job_location
FROM
    job_postings_fact;

/* Label new column as follows:
- 'Anywhere' as 'Remote'
- 'New York' as 'Local'
- 'Otherwise 'Onsite' */

SELECT
    job_title_short,
    job_location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact;


-- Now analize how many analyst are working in each location category
SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact
GROUP BY
    location_category;

-- Now filter only Data Analysts

SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category
ORDER BY
    number_of_jobs DESC;

-- Practice Problem
-- I want to categorize the salaries from each job posting to see if it fits my desired salary range
-- Put the salary into different buckets
-- Define what's high,standard or low salary
-- I only want to look at Data Analyst jobs
-- Order from higher to lower salary

SELECT
    job_title,
    ROUND(salary_year_avg, 2) AS yearly_salary,
    CASE
        WHEN salary_year_avg > 100000 THEN 'High Salary'
        WHEN salary_year_avg BETWEEN 80000 AND 100000 THEN 'Standard Salary'
        ELSE 'Low Salary'
    END AS salary_category
FROM
    job_postings_fact
WHERE
    job_title LIKE '%Data_Analyst%'
ORDER BY
    yearly_salary ASC;

----



SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN salary_year_avg > 100000 THEN 'High Salary'
        WHEN salary_year_avg BETWEEN 80000 AND 100000 THEN 'Standard Salary'
        ELSE 'Low Salary'
    END AS salary_category

FROM
    job_postings_fact

GROUP BY
    salary_category
ORDER BY
    number_of_jobs DESC;

---
SELECT
    ROUND(AVG(salary_year_avg),2) AS salary,
    CASE
        WHEN salary_year_avg > 100000 THEN 'High Salary'
        WHEN salary_year_avg BETWEEN 80000 AND 100000 THEN 'Standard Salary'
        ELSE 'Low Salary'
    END AS salary_category

FROM
    job_postings_fact

GROUP BY
    salary_category
ORDER BY
    salary DESC;












