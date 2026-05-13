/*
=======================================================
Stored Procedure: sp_create_database
Description: Creates required databases for the solution
Purpose: Initialize staging and data warehouse databases
Author: Data Engineering Team
Date: 2026-05-13
=======================================================
*/

CREATE OR ALTER PROCEDURE sp_create_database
AS
BEGIN
    -- Create Staging Database
    IF DB_ID('PC_Sales_Staging_dtw') IS NULL
    BEGIN
        CREATE DATABASE PC_Sales_Staging_dtw;
        PRINT 'Staging database created successfully.';
    END;

    -- Create Data Warehouse Database
    IF DB_ID('PC_Sales_DWH_dtw') IS NULL
    BEGIN
        CREATE DATABASE PC_Sales_DWH_dtw;
        PRINT 'Data Warehouse database created successfully.';
    END;
END;




