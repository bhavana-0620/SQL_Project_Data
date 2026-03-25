-- 02_top_paying_job_skills.sql

/*
Goal: Identify the specific skills required for the top 10 highest-paying remote Data Analyst jobs.
- Identifies the top 10 paying roles (Remote/Anywhere) from the first query.
- Joins with skills tables to reveal what high-paying employers are looking for.
*/

WITH top_paying_jobs AS (
    SELECT
        jp.job_id,
        jp.job_title,
        jp.salary_year_avg,
        cd.name AS company_name
    FROM
        job_postings_fact AS jp
    LEFT JOIN company_dim AS cd 
        ON jp.company_id = cd.company_id
    WHERE
        jp.job_title_short = 'Data Analyst' AND
        jp.job_location = 'Anywhere' AND
        jp.salary_year_avg IS NOT NULL
    ORDER BY
        jp.salary_year_avg DESC
    LIMIT 10
)

SELECT 
    tpj.*,
    sd.skills
FROM 
    top_paying_jobs AS tpj
INNER JOIN skills_job_dim AS sjd 
    ON tpj.job_id = sjd.job_id
INNER JOIN skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
ORDER BY 
    tpj.salary_year_avg DESC;
