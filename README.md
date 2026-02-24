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
