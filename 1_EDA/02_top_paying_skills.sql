/*
Question: What are the highest-paying skills for data engineers in the United States?
- Calculate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand
- In the United States
- Why? Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture for skill development priorities
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_country = 'United States'
    AND jpf.job_work_from_home = True
GROUP BY 
    sd.skills
HAVING 
    COUNT(jpf.*) > 100
ORDER BY 
    median_salary DESC
LIMIT 25;

/*
Key Insights:
Terraform is the top-paying skill at a $192.75K median salary, while also showing strong demand with 965 postings.
Spring ranks second at a $175.5K median salary, although demand is lower at 172 postings.
Jupyter, Golang, and Mongo follow closely behind:
Jupyter: $156.25K median salary (129 postings)
Golang: $156K median salary (140 postings)
Mongo: $155.5K median salary (111 postings)
Several skills share a $155K median salary, but their demand varies significantly:
Kubernetes: $155K median salary (960 postings)
Ruby: $155K median salary (206 postings)
Bitbucket: $155K median salary (129 postings)
TypeScript: $155K median salary (112 postings)
GraphQL: $155K median salary (109 postings)
Kubernetes stands out among the highest-paying skills because its demand is much stronger than most other skills in the same salary range.
Airflow, Git, AWS, and Kafka show some of the strongest demand across the full dataset:
Airflow: $154K median salary (2,110 postings)
Git: $150.5K median salary (1,411 postings)
AWS: $140K median salary (5,269 postings)
Kafka: $140K median salary (2,018 postings)
AWS has the highest demand in the dataset by a large margin, despite having a lower median salary than the top-ranked skills.
Overall, cloud, infrastructure, DevOps, and data-engineering technologies such as Terraform, Kubernetes, Airflow, AWS, Kafka, and Docker combine relatively high salaries with substantial demand.

Takeaway: Terraform leads in compensation while still maintaining strong demand, making it especially notable compared with several other high-paying but less frequently requested skills.
Kubernetes, Airflow, AWS, and Kafka stand out for balancing competitive salaries with much larger numbers of job postings. Overall, the data suggests that cloud infrastructure, DevOps,
distributed systems, and data-engineering skills offer some of the strongest combinations of compensation and market demand.

┌───────────────┬───────────────┬──────────────┐
│    skills     │ median_salary │ demand_count │
│    varchar    │    double     │    int64     │
├───────────────┼───────────────┼──────────────┤
│ terraform     │      192750.0 │          965 │
│ spring        │      175500.0 │          172 │
│ jupyter       │      156250.0 │          129 │
│ golang        │      156000.0 │          140 │
│ mongo         │      155527.0 │          111 │
│ kubernetes    │      155000.0 │          960 │
│ ruby          │      155000.0 │          206 │
│ typescript    │      155000.0 │          112 │
│ bitbucket     │      155000.0 │          129 │
│ graphql       │      155000.0 │          109 │
│ gdpr          │      155000.0 │          120 │
│ c             │      154000.0 │          159 │
│ airflow       │      154000.0 │         2110 │
│ ansible       │      153000.0 │          122 │
│ git           │      150500.0 │         1411 │
│ redis         │      150000.0 │          124 │
│ perl          │      148750.0 │          104 │
│ react         │      145750.0 │          138 │
│ looker        │      145000.0 │          426 │
│ dynamodb      │      141250.0 │          368 │
│ pandas        │      140000.0 │          422 │
│ aws           │      140000.0 │         5269 │
│ elasticsearch │      140000.0 │          200 │
│ kafka         │      140000.0 │         2018 │
│ docker        │      140000.0 │          868 │
└───────────────┴───────────────┴──────────────┘
*/