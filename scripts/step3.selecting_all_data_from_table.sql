/*
=======================================================
Script: step3.selecting_all_data_from_table.sql
Description: Select data from all staging dimension and fact tables
Purpose: Verify loaded data for ETL validation and review
Author: Data Engineer Andile Dube
Date: 2026-05-14
=======================================================
*/

-- Verify dim_location
SELECT
    *
FROM
    [PC_Sales_Staging_dtw].[dbo].[dim_location];

-- Verify dim_priority
SELECT
    *
FROM
    [PC_Sales_Staging_dtw].[dbo].[dim_priority];

-- Verify dim_payment
SELECT
    *
FROM
    [PC_Sales_Staging_dtw].[dbo].[dim_payment];

-- Verify dim_store
SELECT
    *
FROM
    [PC_Sales_Staging_dtw].[dbo].[dim_store];

-- Verify dim_date
SELECT
    *
FROM
    [PC_Sales_Staging_dtw].[dbo].[dim_date];

-- Verify dim_customer
SELECT
    *
FROM
    [PC_Sales_Staging_dtw].[dbo].[dim_customer];

-- Verify dim_pc_spec
SELECT
    *
FROM
    [PC_Sales_Staging_dtw].[dbo].[dim_pc_spec];

-- Verify dim_channel
SELECT
    *
FROM
    [PC_Sales_Staging_dtw].[dbo].[dim_channel];

-- Verify Fact_pc_sales
SELECT
    *
FROM
    [PC_Sales_Staging_dtw].[dbo].[Fact_pc_sales];