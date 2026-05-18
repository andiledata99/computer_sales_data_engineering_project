/*
=======================================================
Stored Procedure: sp_create_dim_priority
Description: Creates and populates dim_priority dimension
Purpose: Store priority level information
Author: Data Engineer Andile Dube
Date: 2026-05-13
=======================================================
*/

CREATE OR ALTER PROCEDURE dbo.sp_create_dim_priority
AS
BEGIN
    SET NOCOUNT ON;

    -- Dim priority dimension table creation
    IF OBJECT_ID('PC_Sales_Staging_dtw.dbo.dim_priority', 'U') IS NULL
    BEGIN
        CREATE TABLE [PC_Sales_Staging_dtw].[dbo].[dim_priority](
            [Priority_ID] int IDENTITY(1,1) PRIMARY KEY,
            [Priority] [nvarchar](50) NOT NULL,
            [Load_date] DATETIME DEFAULT GETDATE()
        );
    END;

    -- Insert distinct priority records from raw data, avoid duplicates
    INSERT INTO [PC_Sales_Staging_dtw].[dbo].[dim_priority]([Priority])
    SELECT DISTINCT rd.[Priority]
    FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data] rd
    WHERE NOT EXISTS (
        SELECT 1 FROM [PC_Sales_Staging_dtw].[dbo].[dim_priority] d
        WHERE d.Priority = rd.Priority
    );

    -- Verification Query: Display loaded priority dimension records
    SELECT * FROM [PC_Sales_Staging_dtw].[dbo].[dim_priority];
END;
GO