/*
=======================================================
Stored Procedure: sp_create_dim_store
Description: Creates and populates dim_store dimension
Purpose: Store store information
Author: Data Engineer Andile Dube
Date: 2026-05-13
=======================================================
*/

CREATE OR ALTER PROCEDURE dbo.sp_create_dim_store
AS
BEGIN
    SET NOCOUNT ON;

    -- Dim store dimension table creation
    IF OBJECT_ID('PC_Sales_Staging_dtw.dbo.dim_store', 'U') IS NULL
    BEGIN
        CREATE TABLE [PC_Sales_Staging_dtw].[dbo].[dim_store](
            [Shop_ID] int IDENTITY(1,1) PRIMARY KEY,
            [Shop_Name] [nvarchar](50) NOT NULL,
            [Shop_Age] [nvarchar](50) NOT NULL,
            [Load_date] DATETIME DEFAULT GETDATE()
        );
    END;

    -- Insert distinct store records from raw data, avoid duplicates
    INSERT INTO [PC_Sales_Staging_dtw].[dbo].[dim_store](
        [Shop_Name],
        [Shop_Age]
    )
    SELECT DISTINCT rd.[Shop_Name], rd.[Shop_Age]
    FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data] rd
    WHERE NOT EXISTS (
        SELECT 1 FROM [PC_Sales_Staging_dtw].[dbo].[dim_store] d
        WHERE d.Shop_Name = rd.Shop_Name
          AND d.Shop_Age = rd.Shop_Age
    );

    -- Verification Query: Display loaded store dimension records
    SELECT * FROM [PC_Sales_Staging_dtw].[dbo].[dim_store];
END;
GO