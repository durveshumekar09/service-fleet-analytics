# Service Fleet Analytics

End-to-end analytics project using **Python**, **Snowflake (SQL)**, and **Power BI** to analyze service fleet operations, identify high-risk assets, understand department workload, and evaluate maintenance cost impact.

> Status: Data cleaning and Snowflake data model + views are complete. Power BI dashboard will be added next.

---

## 🧩 Business Problem

Operations teams often lack a **clear, data-driven view** of their service fleet performance.  
Key challenges include:

- No single view of **how service volume changes over time**
- Difficulty identifying **which assets are most problematic (high-risk)**
- Limited visibility into **which departments drive most maintenance work**
- Poor understanding of **where maintenance costs are concentrated**

Without this visibility, it is hard to:
- Prioritize preventive maintenance
- Allocate resources effectively
- Control maintenance costs
- Make informed replace-vs-repair decisions

---

## 🎯 Business Objectives

- Track **monthly service volume trends**
- Identify **high-risk assets** based on service frequency
- Analyze **department-wise maintenance workload**
- Understand **maintenance cost distribution by department**
- Provide **BI-ready datasets** for management reporting

---

## 💡 Solution Overview

This project implements a **reproducible analytics pipeline**:

1. **Python (pandas)** cleans and prepares raw service fleet data  
2. **Snowflake** stores data in a RAW → FINAL (curated) model  
3. **SQL views** provide analytics-ready datasets for BI  
4. **Power BI** (to be added) visualizes trends, risk, workload, and cost impact  

Key outputs:
- Clean fact table: `SERVICE_EVENTS`
- Analytical views:
  - `VW_MONTHLY_TREND`
  - `VW_HIGH_RISK_ASSETS`
  - `VW_DEPARTMENT_TREND`
  - `VW_COST_BY_DEPARTMENT`

---

## 🧱 Tech Stack

- **Python** (pandas) – data cleaning & preparation  
- **Snowflake** – data warehousing & SQL analytics  
- **SQL** – transformations, KPIs, and analytical views  
- **Power BI** – dashboarding (coming next)  

---

## 📁 Repository Structure
