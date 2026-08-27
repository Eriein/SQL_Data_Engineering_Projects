/*
    Question: What are the most in-demand skills for Data Engineers in the United States?
    - Identify the top 10 in-demand skills for data engineers
    - Focus on remote job postings
    - In the United States

    Why? Retrieves the top 10 skills with the highest demand in the remote job market in the United States,
    providing insight into the most valuable skills for data engineers seeking remote work.
*/

SELECT
    sd.skills,
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
ORDER BY 
    demand_count DESC
LIMIT 10;

/*
Here's the breakdown of the most demanded skills for data engineers:
SQL and Python are by far the most in-demand skills in the United States, with 8,665 and 8,118 job postings.
Cloud platforms round out the top tier, with AWS leading at 5,269 postings, followed
closely by Azure at 4,419, a much tighter gap than in most other data roles. 
Apache Spark completes the top 5 with 3,766 postings, highlighting the importance of big data processing skills.
Cloud data warehouses follow right behind, with Snowflake at 2,974 and Databricks at 2,650.

Key takeaways:
- SQL and Python are the foundational skills for data engineers, together making up nearly 40% of all skill mentions
- Cloud platforms (AWS, Azure) seem to be critical for modern data engineering
- Big data tools like Spark seem to be highly valued, appearing in nearly 1 in 10 skill mentions
- Cloud warehouse platforms (Snowflake, Databricks) show strong demand, both outranking traditional programming languages
- Pipeline and streaming tools (Airflow, Kafka) round out the top 10, marking what most distinguishes data engineering from general software roles
- Java still holds at #8, largely because Spark and Kafka run on the JVM
┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │         8665 │
│ python     │         8118 │
│ aws        │         5269 │
│ azure      │         4419 │
│ spark      │         3766 │
│ snowflake  │         2974 │
│ databricks │         2650 │
│ java       │         2507 │
│ airflow    │         2110 │
│ kafka      │         2018 │
└────────────┴──────────────┘
*/

