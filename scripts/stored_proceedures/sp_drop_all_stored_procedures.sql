/*
=======================================================
Drop All Stored Procedures Script
Description: Removes all stored procedures from the database
Purpose: Clean up and remove stored procedures for redeployment
Author: Data Engineering Team
Date: 2026-05-13
Usage: Execute this script when redeploying or cleaning up
=======================================================
*/

PRINT '========================================='
PRINT 'Starting Stored Procedures Cleanup...'
PRINT '=========================================';

-- Drop Master Execution Procedure
IF OBJECT_ID('sp_execute_all_procedures', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE sp_execute_all_procedures;
    PRINT 'Dropped procedure: sp_execute_all_procedures'
END;

-- Drop Fact Table Creation Procedure
IF OBJECT_ID('sp_create_fact_pc_sales', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE sp_create_fact_pc_sales;
    PRINT 'Dropped procedure: sp_create_fact_pc_sales'
END;

-- Drop Dimension Table Creation Procedures
IF OBJECT_ID('sp_create_dim_store', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE sp_create_dim_store;
    PRINT 'Dropped procedure: sp_create_dim_store'
END;

IF OBJECT_ID('sp_create_dim_priority', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE sp_create_dim_priority;
    PRINT 'Dropped procedure: sp_create_dim_priority'
END;

IF OBJECT_ID('sp_create_dim_pc_spec', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE sp_create_dim_pc_spec;
    PRINT 'Dropped procedure: sp_create_dim_pc_spec'
END;

IF OBJECT_ID('sp_create_dim_payment', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE sp_create_dim_payment;
    PRINT 'Dropped procedure: sp_create_dim_payment'
END;

IF OBJECT_ID('sp_create_dim_location', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE sp_create_dim_location;
    PRINT 'Dropped procedure: sp_create_dim_location'
END;

IF OBJECT_ID('sp_create_dim_date', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE sp_create_dim_date;
    PRINT 'Dropped procedure: sp_create_dim_date'
END;

IF OBJECT_ID('sp_create_dim_customer', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE sp_create_dim_customer;
    PRINT 'Dropped procedure: sp_create_dim_customer'
END;

IF OBJECT_ID('sp_create_dim_channel', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE sp_create_dim_channel;
    PRINT 'Dropped procedure: sp_create_dim_channel'
END;

-- Drop Database Creation Procedure
IF OBJECT_ID('sp_create_database', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE sp_create_database;
    PRINT 'Dropped procedure: sp_create_database'
END;

PRINT '========================================='
PRINT 'All stored procedures dropped successfully!'
PRINT '=========================================';
GO
