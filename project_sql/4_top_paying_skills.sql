-- 04_top_paying_skills.sql

/*
Goal: Identify the highest-paying skills for remote Data Analyst roles.
- Analyzes the average salary associated with each skill.
- Requirement: The skill must appear in at least 5 job postings to ensure statistical relevance (avoids outliers).
*/

WITH skill_stats AS (
    SELECT 
        sd.skills,
        COUNT(sjd.job_id) AS job_count,
        AVG(jp.salary_year_avg) AS avg_salary
    FROM 
        job_postings_fact AS jp
    INNER JOIN skills_job_dim AS sjd 
        ON jp.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd 
        ON sjd.skill_id = sd.skill_id
    WHERE 
        jp.job_title_short = 'Data Analyst' 
        AND jp.salary_year_avg IS NOT NULL
        AND jp.job_work_from_home = TRUE
    GROUP BY 
        sd.skills
)

SELECT 
    skills,
    ROUND(avg_salary, 0) AS avg_salary
FROM 
    skill_stats
WHERE 
    job_count >= 5  -- Ensures the data point is reliable
ORDER BY 
    avg_salary DESC
LIMIT 25;
