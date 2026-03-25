-- 03_top_demanded_skills.sql

/*
Goal: Identify the top 5 most in-demand skills for remote Data Analyst roles.
- Top 5 in-demand skills for a data analyst
- Focus on all job postings.
*/

WITH total_remote_postings AS (
    SELECT 
        COUNT(job_id) AS total_count
    FROM 
        job_postings_fact
    WHERE 
        job_title_short = 'Data Analyst' 
        AND job_work_from_home = TRUE
)

SELECT 
    sd.skills,
    COUNT(sjd.job_id) AS demand_count,
    ROUND(COUNT(sjd.job_id) * 100.0 / (SELECT total_count FROM total_remote_postings), 2) AS demand_percentage
FROM 
    job_postings_fact AS jp
INNER JOIN skills_job_dim AS sjd 
    ON jp.job_id = sjd.job_id
INNER JOIN skills_dim AS sd 
    ON sjd.skill_id = sd.skill_id
WHERE 
    jp.job_title_short = 'Data Analyst' 
    AND jp.job_work_from_home = TRUE
GROUP BY 
    sd.skills
ORDER BY 
    demand_count DESC
LIMIT 5;
