/* Questions to answer
-- 1. What are the top paying jobs for my role?
-- 2. What are the skills required for these top paying roles?
-- 3. What are the most in-demand skills for my role?
-- 4. What are the top skills based on salary for my role?
-- 5. What are the mos optimal skills to learn?
*/

-- 3. What are the most in-demand skills for my role?
-- Identify the top 5 in-demand skills for the Data Analyst role that are required for remote job postings.
-- Why? Provides the insights into the most valuable skills for Data Analysts in the remote job market.

SELECT 
    skills,
    COUNT(skills_job_dim.skill_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;














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







