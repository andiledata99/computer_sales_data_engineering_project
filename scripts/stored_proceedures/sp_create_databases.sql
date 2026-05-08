CREATE PROCEDURE sp_create_database
AS
BEGIN
    /* Create Staging Database */
    IF DB_ID('PC_Sales_Staging_dtw') IS NULL
    BEGIN
        CREATE DATABASE PC_Sales_Staging_dtw;
    END;

    /* Create Data Warehouse Database */
    IF DB_ID('PC_Sales_DWH_dtw') IS NULL
    BEGIN
        CREATE DATABASE PC_Sales_DWH_dtw;
    END;
END;
GO




