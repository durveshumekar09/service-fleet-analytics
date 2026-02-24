# Service Fleet Analytics

End-to-end analytics project using **Python**, **Snowflake (SQL)**, and **Power BI** to analyze service fleet operations, identify high-risk assets, understand department workload, and evaluate maintenance cost impact.

> Status: Data cleaning and Snowflake data model + views are complete. Power BI dashboard will be added next.

---

## 🚀 Project Overview

This project demonstrates a complete, reproducible analytics workflow:

1. **Data Cleaning (Python / pandas)**
   - Loaded raw fleet service data
   - Handled missing values, duplicates, and date normalization
   - Standardized columns and exported analysis-ready CSV files

2. **Data Warehouse (Snowflake)**
   - Created a staging (RAW) table and a curated (FINAL) table
   - Safely converted formatted cost values (e.g., `1,033.04`) into numeric
   - Built analytical tables and views for reporting and BI consumption

3. **Analytics & BI (SQL + Power BI)**
   - Created SQL views for:
     - Monthly service trends
     - High-risk assets (most serviced)
     - Department-wise service workload
     - Cost by department
   - These views are used as the data source for the Power BI dashboard 

---

## 🧱 Tech Stack

- **Python** (pandas) – data cleaning & preparation  
- **Snowflake** – data warehousing & SQL analytics  
- **SQL** – transformations, KPIs, and analytical views  
- **Power BI** – dashboarding   

---

## 📁 Repository Structure
service-fleet-analytics/
│
├── notebooks/
│   └── 01_clean.ipynb
│       # Python notebook for data cleaning (pandas)
│
├── data_clean/
│   ├── service_events_clean.csv
│   └── assets_clean.csv
│       # Cleaned, analysis-ready CSV files
│
├── sql/
│   ├── 01_create_tables.sql
│   │   # Creates DB, schema, ASSETS, SERVICE_EVENTS_RAW, and final SERVICE_EVENTS
│   │
│   ├── 02_create_views.sql
│   │   # Creates analytical views:
│   │   # VW_MONTHLY_TREND, VW_HIGH_RISK_ASSETS, VW_DEPARTMENT_TREND, VW_COST_BY_DEPARTMENT
│   │
│   └── 03_kpi_queries.sql
│       # KPI and validation queries for checks and screenshots
│
├── screenshots/
│   ├── snowflake_objects.png
│   ├── service_events_count.png
│   ├── total_cost_check.png
│   ├── vw_monthly_trend_result.png
│   └── vw_cost_by_department_result.png
│       # Proof of Snowflake setup and results
│
├── powerbi/
│   └── fleet_dashboard.pbix
│       # (Add later) Power BI dashboard file
│
└── README.md
    # Project overview, setup steps, and explanation

