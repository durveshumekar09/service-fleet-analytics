-- =========================
-- 03_kpi_queries.sql
-- KPI & analysis queries (for checks and screenshots)
-- =========================

USE DATABASE FLEET_ANALYTICS;
USE SCHEMA PUBLIC;

-- Total services (work orders)
SELECT COUNT(*) AS total_services
FROM SERVICE_EVENTS;

-- Total assets
SELECT COUNT(DISTINCT ASSET_ID) AS total_assets
FROM SERVICE_EVENTS;

-- Top 20 most serviced assets (high-risk)
SELECT ASSET_ID, COUNT(*) AS service_count
FROM SERVICE_EVENTS
GROUP BY ASSET_ID
ORDER BY service_count DESC
LIMIT 20;

-- Monthly service trend
SELECT SERVICE_MONTH, COUNT(*) AS total_services
FROM SERVICE_EVENTS
GROUP BY SERVICE_MONTH
ORDER BY SERVICE_MONTH;

-- Department trend
SELECT DEPARTMENT, COUNT(*) AS total_services
FROM SERVICE_EVENTS
GROUP BY DEPARTMENT
ORDER BY total_services DESC;

-- Cost by department (check view logic)
SELECT *
FROM VW_COST_BY_DEPARTMENT
ORDER BY TOTAL_COST DESC;