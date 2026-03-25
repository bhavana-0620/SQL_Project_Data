-- 01_top_paying_jobs.sql

/*
Goal: Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focuses on 'Data Analyst' roles only.
- Filters for 'Anywhere' (Remote) locations.
- Ensures salary data is present by removing NULL values.
*/

WITH remote_job_postings AS (
    SELECT
        jp.job_id,
        jp.job_title,
        jp.job_location,
        jp.job_schedule_type,
        jp.salary_year_avg,
        jp.job_posted_date,
        cd.name AS company_name
    FROM 
        job_postings_fact AS jp
    LEFT JOIN company_dim AS cd 
        ON jp.company_id = cd.company_id
    WHERE
        jp.job_title_short = 'Data Analyst' AND 
        jp.job_location = 'Anywhere' AND 
        jp.salary_year_avg IS NOT NULL
)

SELECT 
    *
FROM 
    remote_job_postings
ORDER BY 
    salary_year_avg DESC
LIMIT 10;
