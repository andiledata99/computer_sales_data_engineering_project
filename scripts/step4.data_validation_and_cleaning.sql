/*
=======================================================
Script: step4.data_validation_and_cleaning.sql
Description: Runs raw data validation, cleaning, and cleaned ETL load
Purpose: Produce validated staging data and populate cleaned dimensions/fact tables
Author: Data Engineer Andile Dube
Date: 2026-05-14
=======================================================
*/

PRINT 'Starting raw data validation and cleaning stage';
EXECUTE sp_validate_and_clean_raw_pc_data;
PRINT 'Raw data validation complete';

PRINT 'Loading cleaned data into dimensions and fact table';
EXECUTE sp_load_cleaned_dim_and_fact_data;
PRINT 'Cleaned data load complete';

PRINT 'Data validation and cleaning pipeline finished successfully';

-- Review any invalid rows
SELECT TOP 100 *
FROM PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Errors;

-- Verify cleaned staging row counts
SELECT
    COUNT(*) AS CleanedRowCount
FROM PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Cleaned;

-- Verify fact rows created
SELECT
    COUNT(*) AS FactRowCount
FROM PC_Sales_Staging_dtw.dbo.Fact_pc_sales;
