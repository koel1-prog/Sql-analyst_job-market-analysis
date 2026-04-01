-- Top 25 Highest-Paying Skills for Remote Data Analyst Jobs
SELECT 
    skills,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM job_postings_fact
LEFT JOIN skills_job_dim
ON job_postings_fact.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim
ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25;


-- PySpark ($208K) leads the pack, followed by Bitbucket and Couchbase, showing niche but extremely lucrative skills.

-- ML & Data Science tools — DataRobot, Jupyter, Pandas, NumPy — consistently deliver salaries above $140K, proving their central role in remote analytics.

-- DevOps, cloud, and programming skills — GitLab, Golang, Kubernetes, Swift — are highly valued, blending engineering with analytics for premium pay.
