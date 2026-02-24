-- =========================
-- 01_create_tables.sql
-- Create database, schema, and tables
-- =========================

-- Create DB + Schema
CREATE DATABASE IF NOT EXISTS FLEET_ANALYTICS;
USE DATABASE FLEET_ANALYTICS;

CREATE SCHEMA IF NOT EXISTS PUBLIC;
USE SCHEMA PUBLIC;

-- Create ASSETS table (final)
CREATE OR REPLACE TABLE ASSETS (
  ASSET_ID STRING,
  DEPARTMENT STRING
);

-- Create SERVICE_EVENTS_RAW table (staging/raw)
-- NOTE: TOTAL_COST_STR is STRING so Snowflake can load values like '1,033.04'
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
-- MANUAL STEP (do in Snowflake UI):
-- Load data_clean/assets_clean.csv        -> ASSETS
-- Load data_clean/service_events_clean.csv -> SERVICE_EVENTS_RAW
-- Make sure: "First row is header" / Skip header = 1
-- =========================

--  Verify row loads
SELECT COUNT(*) AS assets_rows FROM ASSETS;
SELECT COUNT(*) AS raw_service_rows FROM SERVICE_EVENTS_RAW;

-- Create final SERVICE_EVENTS table 
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

-- Verify final table
SELECT COUNT(*) AS final_service_rows FROM SERVICE_EVENTS;

SELECT
  COUNT(*) AS rows_loaded,
  COUNT_IF(TOTAL_COST IS NULL) AS null_cost_rows,
  MIN(TOTAL_COST) AS min_cost,
  MAX(TOTAL_COST) AS max_cost
FROM SERVICE_EVENTS;