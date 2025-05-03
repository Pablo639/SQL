/*
Find the count of the number of remote postings per skill
- Display the top 5 skills by their demand in remote job
- Include skill ID, and count of postings requiring skills
*/

--- We can use the skills_job_dim table to find the skills that are required for each job posting.
--- Then we can join this with the job_postings_fact table to filter for remote postings.

SELECT
    job_postings.job_id,
    skill_id,
    job_postings.job_work_from_home
FROM
    skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
WHERE
    job_postings.job_work_from_home = TRUE;


-----
WITH remote_job_skills AS(
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE
        job_postings.job_work_from_home = TRUE
    GROUP BY
        skill_id
)

SELECT 
    skills.skill_id,
    skills AS skill_name,
    remote_job_skills.skill_count

FROM
    remote_job_skills 
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY
    remote_job_skills.skill_count DESC
LIMIT 5;

-- FOR DATA ANALYSTS ONLY:

WITH remote_job_skills AS(
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE
        job_postings.job_work_from_home = TRUE AND
        job_postings.job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)

SELECT 
    skills.skill_id,
    skills AS skill_name,
    remote_job_skills.skill_count

FROM
    remote_job_skills 
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY
    remote_job_skills.skill_count DESC
LIMIT 5;





