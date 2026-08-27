/*
Question: What are the most optimal skills for data engineers—balancing both demand and salary in the United States?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions with specified annual salaries.
- In the United States
- Why?
    - This approach highlights skills that balance market demand and financial reward. It weights core skills appropriately instead of letting rare, outlier skills distort the results.
    - The natural log transformation ensures that both high-salary and widely in-demand skills surface as the most practical and valuable to learn for data engineering careers.
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
    COUNT(jpf.*) AS demand_count,
    ROUND(LN(COUNT(jpf.*)), 1) AS ln_demand_count,
    ROUND((MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*))) / 1_000_000, 2) AS optimal_score
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_country = 'United States'
    AND jpf.job_work_from_home = True
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY 
    sd.skills
HAVING 
    COUNT(jpf.*) > 100
ORDER BY 
    optimal_score DESC
LIMIT 25;

/*
Key Insights:

Terraform ranks first with the highest optimal score of 0.96, supported by the highest median salary at $192.75K and 146 postings.
Python ranks second with a 0.91 optimal score, combining a $135.5K median salary with the highest demand in the dataset at 853 postings.
AWS and SQL also score very highly due to their strong combination of salary and demand:
AWS: $140K median salary (583 postings), optimal score 0.89
SQL: $130K median salary (850 postings), optimal score 0.88
Airflow stands out as one of the strongest specialized data-engineering skills, with a $154K median salary, 298 postings, and an optimal score of 0.88.
Other skills with a strong balance of compensation and demand include:
Spark: $140K median salary (369 postings), score 0.83
Snowflake: $139.5K median salary (352 postings), score 0.82
Git: $150.5K median salary (176 postings), score 0.78
Azure: $130K median salary (358 postings), score 0.76
Kafka: $140K median salary (189 postings), score 0.73
Kubernetes has one of the highest median salaries at $155K, but its lower demand of 101 postings reduces its optimal score to 0.72.
Databricks, Scala, and Java fall in a similar middle range, with optimal scores around 0.70–0.72 and moderate demand.
Lower-ranked skills such as SQL Server, Power BI, and Tableau have lower median salaries around $115K–$120K, which contributes to their lower optimal scores despite having reasonable demand.
The logarithmic demand measure helps prevent very common skills such as Python and SQL from completely dominating the ranking, creating a more balanced comparison between salary and market demand.

Takeaway: Terraform provides the strongest overall combination of compensation and demand according to the optimal score, while Python, AWS, SQL, and Airflow also stand out as highly marketable skills.
The results show that the best opportunities are not necessarily the skills with the highest salary alone, but those that combine strong pay with consistent demand.
┌────────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
│   skills   │ median_salary │ demand_count │ ln_demand_count │ optimal_score │
│  varchar   │    double     │    int64     │     double      │    double     │
├────────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
│ terraform  │      192750.0 │          146 │             5.0 │          0.96 │
│ python     │      135500.0 │          853 │             6.7 │          0.91 │
│ aws        │      140000.0 │          583 │             6.4 │          0.89 │
│ sql        │      130000.0 │          850 │             6.7 │          0.88 │
│ airflow    │      154000.0 │          298 │             5.7 │          0.88 │
│ spark      │      140000.0 │          369 │             5.9 │          0.83 │
│ snowflake  │      139500.0 │          352 │             5.9 │          0.82 │
│ git        │      150500.0 │          176 │             5.2 │          0.78 │
│ azure      │      130000.0 │          358 │             5.9 │          0.76 │
│ kafka      │      140000.0 │          189 │             5.2 │          0.73 │
│ kubernetes │      155000.0 │          101 │             4.6 │          0.72 │
│ scala      │      137500.0 │          185 │             5.2 │          0.72 │
│ databricks │      135500.0 │          202 │             5.3 │          0.72 │
│ java       │      130000.0 │          214 │             5.4 │           0.7 │
│ redshift   │      130000.0 │          198 │             5.3 │          0.69 │
│ pyspark    │      140000.0 │          120 │             4.8 │          0.67 │
│ nosql      │      135500.0 │          138 │             4.9 │          0.67 │
│ hadoop     │      135000.0 │          144 │             5.0 │          0.67 │
│ gcp        │      136000.0 │          119 │             4.8 │          0.65 │
│ r          │      135290.0 │          116 │             4.8 │          0.64 │
│ sql server │      120000.0 │          116 │             4.8 │          0.57 │
│ power bi   │      120070.0 │          111 │             4.7 │          0.57 │
│ tableau    │      115000.0 │          133 │             4.9 │          0.56 │
└────────────┴───────────────┴──────────────┴─────────────────┴───────────────┘
*/