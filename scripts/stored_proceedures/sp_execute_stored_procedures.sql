/*
=======================================================
Stored Procedure: sp_execute_all_procedures
Description: Master orchestration procedure for ETL pipeline
Purpose: Execute all dimensional and fact table creation procedures
Author: Data Engineer Andile Dube
Date: 2026-05-13
=======================================================
*/

CREATE OR ALTER PROCEDURE dbo.sp_execute_all_procedures
AS
BEGIN
    SET NOCOUNT ON;

    -- Execute Database Creation Procedure
    PRINT 'Creating Databases...';
    EXECUTE dbo.sp_create_database;
    PRINT 'Databases created successfully.';

    -- Execute Dimension Table Creation Procedures
    PRINT 'Creating Dimension Tables...';
    EXECUTE dbo.sp_create_dim_channel;
    PRINT 'Channel Dimension created.';

    EXECUTE dbo.sp_create_dim_customer;
    PRINT 'Customer Dimension created.';

    EXECUTE dbo.sp_create_dim_date;
    PRINT 'Date Dimension created.';

    EXECUTE dbo.sp_create_dim_location;
    PRINT 'Location Dimension created.';

    EXECUTE dbo.sp_create_dim_payment;
    PRINT 'Payment Dimension created.';

    EXECUTE dbo.sp_create_dim_pc_spec;
    PRINT 'PC Spec Dimension created.';

    EXECUTE dbo.sp_create_dim_priority;
    PRINT 'Priority Dimension created.';

    EXECUTE dbo.sp_create_dim_store;
    PRINT 'Store Dimension created.';

    -- Execute Fact Table Creation and Data Insertion Procedure
    PRINT 'Creating Fact Tables and Loading Data...';
    EXECUTE dbo.sp_create_fact_pc_sales;
    PRINT 'Fact table created and data loaded successfully.';

    -- Execute Main Fact Table Population
    PRINT 'Executing main fact table population...';

END;
GO
    
