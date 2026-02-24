-- =========================
-- FLEET ANALYTICS: END-TO-END FLOW (Snowflake)
-- =========================

-- 0) Create DB + Schema
CREATE DATABASE FLEET_ANALYTICS;
USE DATABASE FLEET_ANALYTICS;

CREATE SCHEMA PUBLIC;
USE SCHEMA PUBLIC;

-- 1) Create ASSETS table 
CREATE TABLE ASSETS (
  ASSET_ID STRING,
  DEPARTMENT STRING
);

-- 2) Create SERVICE_EVENTS_RAW table (staging/raw)
--    NOTE: total_cost_str is STRING so Snowflake can load values like '1,033.04'
CREATE OR REPLACE TABLE SERVICE_EVENTS_RAW (
  WORK_ORDER_ID STRING,
  ASSET_ID STRING,
  JOB_TYPE STRING,
  STATUS STRING,
  OPENED_AT DATE,
  CLOSED_AT DATE,
  DEPARTMENT STRING,
  TOTAL_COST_STR STRING,
  SERVICE_MONTH STRING
);

-- =========================
-- 3) LOAD DATA (MANUAL UI STEP)
-- =========================
-- Use Snowflake UI:
-- Data > Add Data > Load data into a Table
--   a) Load data_clean/assets_clean.csv        -> table ASSETS
--   b) Load data_clean/service_events_clean.csv -> table SERVICE_EVENTS_RAW

-- After loading, verify row counts:
SELECT COUNT(*) AS assets_rows FROM ASSETS;
SELECT COUNT(*) AS raw_service_rows FROM SERVICE_EVENTS_RAW;

-- 4) Create SERVICE_EVENTS (final clean table) from RAW
CREATE OR REPLACE TABLE SERVICE_EVENTS AS
SELECT
  WORK_ORDER_ID,
  ASSET_ID,
  JOB_TYPE,
  STATUS,
  OPENED_AT,
  CLOSED_AT,
  DEPARTMENT,
  TRY_TO_DOUBLE(REPLACE(TOTAL_COST_STR, ',', '')) AS TOTAL_COST,
  SERVICE_MONTH
FROM SERVICE_EVENTS_RAW;

-- 5) Verify final SERVICE_EVENTS table
SELECT COUNT(*) AS final_service_rows FROM SERVICE_EVENTS;

SELECT
  COUNT(*) AS rows_loaded,
  COUNT_IF(TOTAL_COST IS NULL) AS null_cost_rows,
  MIN(TOTAL_COST) AS min_cost,
  MAX(TOTAL_COST) AS max_cost
FROM SERVICE_EVENTS;

-- 6) KPI Queries (optional checks)
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

-- 7) Create Views for Power BI
CREATE OR REPLACE VIEW VW_MONTHLY_TREND AS
SELECT SERVICE_MONTH, COUNT(*) AS TOTAL_SERVICES
FROM SERVICE_EVENTS
GROUP BY SERVICE_MONTH;

CREATE OR REPLACE VIEW VW_HIGH_RISK_ASSETS AS
SELECT ASSET_ID, COUNT(*) AS SERVICE_COUNT
FROM SERVICE_EVENTS
GROUP BY ASSET_ID;

CREATE OR REPLACE VIEW VW_DEPARTMENT_TREND AS
SELECT DEPARTMENT, COUNT(*) AS TOTAL_SERVICES
FROM SERVICE_EVENTS
GROUP BY DEPARTMENT;

-- Add-on View: Cost by Department (impact upgrade)
CREATE OR REPLACE VIEW VW_COST_BY_DEPARTMENT AS
SELECT
  DEPARTMENT,
  SUM(COALESCE(TOTAL_COST, 0)) AS TOTAL_COST,
  AVG(COALESCE(TOTAL_COST, 0)) AS AVG_COST_PER_SERVICE,
  COUNT(*) AS TOTAL_SERVICES
FROM SERVICE_EVENTS
GROUP BY DEPARTMENT
ORDER BY TOTAL_COST DESC;

-- 8) Final: What to load in Power BI
-- Power BI -> Get Data -> Snowflake -> Load these VIEWS:
--   VW_MONTHLY_TREND
--   VW_DEPARTMENT_TREND
--   VW_HIGH_RISK_ASSETS
--   VW_COST_BY_DEPARTMENT