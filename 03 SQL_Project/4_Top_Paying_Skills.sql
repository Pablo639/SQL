/* Questions to answer
-- 1. What are the top paying jobs for my role?
-- 2. What are the skills required for these top paying roles?
-- 3. What are the most in-demand skills for my role?
-- 4. What are the top skills based on salary for my role?
-- 5. What are the mos optimal skills to learn?
*/

-- 4. What are the top skills based on salary for my role?

-- Look at the average salary associated with each skill for Data Analysts in remote job postings.
-- Why? Provides insights into the most valuable skills for Data Analysts in the remote job market.

SELECT 
    skills,
    ROUND(AVG(salary_year_avg),2) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'  AND
    salary_year_avg IS NOT NULL 
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 5;













