SELECT
    '2026-03-29' :: DATE,
    123 :: INT,
    TRUE :: BOOLEAN,
    3.14 :: FLOAT;


SELECT 
    count(job_id) AS job_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM 
    job_postings_fact
WHERE 
    job_posted_date >= CURRENT_DATE - INTERVAL '3 years'
GROUP BY 
    month
ORDER BY
    job_count DESC
LIMIT 5;

CREATE TABLE january_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE february_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;


SELECT *
FROM march_jobs;


SELECT 
    count(job_id) AS jobs_no,
    CASE
    WHEN job_location = 'Anywhere' THEN 'Remote'
    WHEN job_location = 'New York, NY' THEN 'LOCAL'
    ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category;



SELECT 
    name as company_name
FROM company_dim
WHERE company_id IN(
    SELECT company_id
    FROM job_postings_fact
    WHERE job_no_degree_mention = TRUE
);


WITH company_job_count AS(
    SELECT 
        company_id,
        count(*) AS total_jobs
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM company_job_count
LEFT JOIN company_dim
ON company_dim.company_id=company_job_count.company_id
ORDER BY total_jobs DESC;



WITH remote_job_skills AS(
    SELECT 
        skill_id,
        count(*) AS skill_count
    FROM skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings
    ON skills_to_job.job_id=job_postings.job_id
    WHERE 
    job_postings.job_work_from_home=TRUE AND
    job_postings.job_title_short='Data Analyst'
    GROUP BY skill_id
)
SELECT 
    skills_dim.skill_id,
    skills AS skill,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim
ON remote_job_skills.skill_id = skills_dim.skill_id
ORDER BY skill_count DESC
LIMIT 10;



SELECT
    job_title_short,
    job_location,
    job_via,
    job_posted_date::DATE,
    salary_year_avg
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS first_quarter
WHERE 
    first_quarter.salary_year_avg > 70000 AND
    first_quarter.job_title_short='Data Analyst'
ORDER BY salary_year_avg DESC;