-- UNION Operators
-- Combine result sets of two or more SELECT statements into a single result set.
-- UNION: Removes duplicate rows from the result set.
-- UNION ALL: Includes all rows, including duplicates.
-- Note: Each SELECT statement must have the same number of columns in the result set with similar data types.


/* UNION*/
-- Get the jobs and companies from January

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION
-- Get the jobs and companies from February

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

-- Get the jobs and companies from March

UNION
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs

/*UNION ALL*/
-- Get the jobs and companies from January

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs

UNION ALL
-- Get the jobs and companies from February

SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

-- Get the jobs and companies from March

UNION ALL
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs
