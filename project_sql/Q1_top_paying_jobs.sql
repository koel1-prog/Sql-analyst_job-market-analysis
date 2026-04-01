-- Top 10 highest-paying Data Analyst jobs in India with company details

SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    company_dim.name AS company_name

FROM 
    job_postings_fact
LEFT JOIN 
    company_dim
ON company_dim.company_id = job_postings_fact.company_id
WHERE 
    job_title_short = 'Data Analyst'
    AND job_location = 'India'
    AND salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10;


-- The highest-paying role is Senior Business & Data Analyst at $119,250/year (Deutsche Bank), followed closely by Sr. Enterprise Data Analyst at $118,140/year (ACA Group).

-- Mid-tier roles like HR Data Operations Analyst (Clarivate) and Financial Data Analyst still offer strong salaries above $100K, while entry-level or niche positions like Data Analyst I (Bristol Myers Squibb) and IT Data Analytic Architect (Merck Group) fall in the $64K–71K range.

-- Overall, analyst roles dominate the dataset, with salaries spanning $64K–119K, showing a clear premium for seniority and specialization.
