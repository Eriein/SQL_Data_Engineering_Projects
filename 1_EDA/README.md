# Exploratory Data Analysis w/ SQL: U.S. Job Market Analysis

![Overview diagram of the project](../images/1_1_Project1_EDA.png)

A SQL project analyzing the **data engineer job market in the United States** using real-world job posting data. It demonstrates my ability to **write production-quality analytical SQL, design efficient queries, and turn business questions into data-driven insights**.

## 🧾 Executive Summary (For Hiring Managers)

- ✅ **Project scope:** Built **3 analytical queries** that answer key questions about the **U.S. data engineer job market**

- ✅ **Data modeling:** Used **multi-table joins** across fact and dimension tables to extract insights

- ✅ **Analytics:** Applied **aggregations, filtering, and sorting** to identify top skills by demand, salary, and overall value

- ✅ **Outcomes:** Delivered **actionable insights** on SQL/Python dominance, cloud trends, skill demand, and salary patterns in the United States

If you only have a minute, review these:

1. [`01_top_demanded_skills.sql`](./01_top_demanded_skills.sql) – demand analysis using multi-table joins

2. [`02_top_paying_skills.sql`](./02_top_paying_skills.sql) – salary analysis using aggregations

3. [`03_optimal_skills.sql`](./03_optimal_skills.sql) – combined demand/salary optimization query

## 🧩 Problem & Context

Understanding the **United States data engineer job market** requires answering questions such as:

- 🎯 **Most in-demand:** _Which skills are most in demand for data engineers in the United States?_

- 💰 **Highest-paying:** _Which skills command the highest salaries?_

- ⚖️ **Best trade-off:** _Which skills offer the best balance between demand and compensation?_

This project analyzes a **data warehouse** built using a star schema design. The warehouse structure consists of:

![Overview diagram of the data warehouse](../images/1_2_Data_Warehouse.png)

- **Fact Table:** `job_postings_fact` – Central table containing job posting details such as job titles, locations, salaries, dates, and more

- **Dimension Tables:**
  - `company_dim` – Company information linked to job postings
  - `skills_dim` – Skills catalog containing skill names and types

- **Bridge Table:** `skills_job_dim` – Resolves the many-to-many relationship between job postings and skills

By querying across these interconnected tables, I extracted insights about skill demand, salary patterns, and high-value skills for **data engineering roles in the United States**.

## 🧰 Tech Stack

- 🐤 **Query Engine:** DuckDB for fast OLAP-style analytical queries

- 🧮 **Language:** SQL (ANSI-style with analytical functions)

- 📊 **Data Model:** Star schema with fact, dimension, and bridge tables

- 🛠️ **Development:** VS Code for SQL editing and Terminal for the DuckDB CLI

- 📦 **Version Control:** Git/GitHub for versioned SQL scripts

## 📂 Repository Structure

```text
1_EDA/
├── 01_top_demanded_skills.sql    # Demand analysis query
├── 02_top_paying_skills.sql      # Salary analysis query
├── 03_optimal_skills.sql         # Combined demand/salary optimization
└── README.md                     # You are here
```

---

## 🏗 Analysis Overview

### Query Structure

1. **[Top Demanded Skills](./01_top_demanded_skills.sql)** – Identifies the 10 most in-demand skills for remote data engineer positions in the United States

2. **[Top Paying Skills](./02_top_paying_skills.sql)** – Analyzes the 25 highest-paying skills using salary and demand metrics for the U.S. data engineer job market

3. **[Optimal Skills](./03_optimal_skills.sql)** – Calculates an optimal score using the natural logarithm of demand combined with median salary to identify skills that offer a strong balance of compensation and market demand

## 💻 SQL Skills Demonstrated

### Query Design & Optimization

- **Complex Joins:** Multi-table `INNER JOIN` operations across `job_postings_fact`, `skills_job_dim`, and `skills_dim`

- **Aggregations:** `COUNT()`, `MEDIAN()`, and `ROUND()` for statistical analysis

- **Filtering:** Boolean logic using `WHERE` clauses and multiple conditions (`job_title_short`, `job_work_from_home`, `salary_year_avg IS NOT NULL`)

- **Sorting & Limiting:** `ORDER BY` with `DESC` and `LIMIT` for top-N analysis

### Data Analysis Techniques

- **Grouping:** `GROUP BY` for categorical analysis by skill

- **Mathematical Functions:** `LN()` for natural logarithm transformation to normalize demand metrics

- **Calculated Metrics:** Derived an optimal score that combines log-transformed demand with median salary

- **HAVING Clause:** Filtered aggregated results to include skills with at least 100 postings

- **NULL Handling:** Properly filtered incomplete salary records using `salary_year_avg IS NOT NULL`
