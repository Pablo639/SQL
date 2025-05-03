-- Title: Subqueries & CTEs

-- Subqueries and Common Table Expressions (CTEs) are powerful tools in SQL that allow you to write complex queries in a more readable and maintainable way. They can be used to break down complex queries into simpler parts, making it easier to understand and debug your SQL code.
-- Subqueries are nested queries that can be used in various parts of a SQL statement, such as the SELECT, FROM, or WHERE clauses. They allow you to retrieve data based on the results of another query.
-- CTEs are a way to create temporary tables that can be used in your SQL queries. They are useful for breaking down complex queries into smaller, more manageable parts.

-- Example of a Subquery
SELECT *
FROM ( -- Subquery starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1 -- 1 = January
) AS january_jobs; 

-- Example of a CTE
WITH january_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1 -- 1 = January
)
SELECT *
FROM january_jobs;

-- I want to find companies that don't have any degree requirement for their job postings
-- First, we see the no degree mention in the job posting fact
SELECT
    company_id,
    job_no_degree_mention
FROM
    job_postings_fact
WHERE
    job_no_degree_mention = TRUE;

-- As we can see, we successfully filtered the job postings that don't require a degree. 
--Now, we want to find the companies that have these job postings.

-- The name of the company is in the company_dim table, and we can use a subquery to find the company_id that has job postings with no degree mention.

SELECT 
    company_id,
    name AS company_name
FROM 
    company_dim
WHERE
    company_id IN (
    SELECT
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = TRUE
    ORDER BY
        company_id
    );

-- Now, we can use a CTE to see the companies with more job postings

SELECT  
    company_id,
    COUNT(*)
FROM
    job_postings_fact
GROUP BY
    company_id


-- Now we want the name of the company. We use WITH in order to build a temporary table with the data we need.

WITH company_job_count AS (
    SELECT  
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)
SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM 
    company_dim
LEFT JOIN company_job_count ON company_dim.company_id = company_job_count.company_id
ORDER BY
    company_job_count.total_jobs DESC;

-- Practice Problem
-- Identify the top 5 skills that are most frequently mentioned in job postings.
-- Use a subquery to find the skill IDs with the hisghest counts in skills_job_dim table and then join
-- this result with the skill_dim table to get the skill names.


SELECT
    skill_id,
    skills,
    Count(*) AS skill_count
FROM
    skills_dim
WHERE
    skill_id IN (
    SELECT
        skill_id
    FROM
        skills_job_dim
    GROUP BY
        skill_id
    ORDER BY
        COUNT(*) DESC
    LIMIT
        5
)
GROUP BY
    skill_id,
    skills

-- This result only show us the names of the skills


SELECT
    skill_id,
    COUNT(*) AS skill_count
FROM
    skills_job_dim
WHERE 
    skill_id IN (
        SELECT
            skill_id
        FROM
            skills_job_dim
    )
GROUP BY
    skill_id
ORDER BY
    skill_count DESC
LIMIT 5;

-- This result only show us the id of the skills and the count of each skill.


WITH skills_count AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim
    GROUP BY
        skill_id

)

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    skills_count.skill_count
FROM
    skills_dim
LEFT JOIN skills_count ON skills_dim.skill_id = skills_count.skill_id
ORDER BY
    skills_count.skill_count DESC
LIMIT 5;

-- Here we can appreciate both names and counts.

-- Practice Problem 2

--Determine the size category for each company by firs identifying 
-- the number of job postings they have. Use a subquery to calculate the total
-- job postings per company. A company is considerde small if it has <10 job postings,
-- medium if the number is between 10 and 50, and large more than 50.

SELECT
    company_id,
    COUNT(*) AS job_postings_count,
    CASE
        WHEN COUNT(*) < 10 THEN 'Small'
        WHEN COUNT(*) BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS company_size_category
FROM
    job_postings_fact
WHERE
    company_id IN (
        SELECT
            company_id
        FROM
            job_postings_fact
    )
GROUP BY
    company_id
ORDER BY
    job_postings_count DESC;

-- now we want the name of the company. We use WITH in order to build a temporary table with the data we need.

WITH company_job_count AS (
    SELECT  
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)
SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs,
    CASE
        WHEN company_job_count.total_jobs < 10 THEN 'Small'
        WHEN company_job_count.total_jobs BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS company_size_category
FROM 
    company_dim
LEFT JOIN company_job_count ON company_dim.company_id = company_job_count.company_id
ORDER BY
    company_job_count.total_jobs DESC;















