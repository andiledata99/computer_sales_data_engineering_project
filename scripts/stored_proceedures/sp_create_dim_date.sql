/*
=======================================================
Stored Procedure: sp_create_dim_date
Description: Creates and populates dim_date dimension
Purpose: Store purchase and shipment date information
Author: Data Engineer Andile Dube
Date: 2026-05-13
=======================================================
*/

CREATE OR ALTER PROCEDURE dbo.sp_create_dim_date
AS
BEGIN
    SET NOCOUNT ON;

    -- Dim date dimension table creation
    IF OBJECT_ID('PC_Sales_Staging_dtw.dbo.dim_date', 'U') IS NULL
    BEGIN
        CREATE TABLE [PC_Sales_Staging_dtw].[dbo].[dim_date](
            [Date_ID] int IDENTITY(1,1) PRIMARY KEY,
            [Purchase_Date] [datetime2](7) NOT NULL,
            [Ship_Date] [nvarchar](50) NULL,
            [Load_date] DATETIME DEFAULT GETDATE()
        );
    END;

    -- Insert distinct date records from raw data, avoid duplicates
    INSERT INTO [PC_Sales_Staging_dtw].[dbo].[dim_date](
        [Purchase_Date],
        [Ship_Date]
    )
    SELECT DISTINCT rd.[Purchase_Date], rd.[Ship_Date]
    FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data] rd
    WHERE NOT EXISTS (
        SELECT 1 FROM [PC_Sales_Staging_dtw].[dbo].[dim_date] d
        WHERE d.Purchase_Date = rd.Purchase_Date
          AND ((d.Ship_Date = rd.Ship_Date) OR (d.Ship_Date IS NULL AND rd.Ship_Date IS NULL))
    );

    -- Verification Query: Display loaded date dimension records
    SELECT * FROM [PC_Sales_Staging_dtw].[dbo].[dim_date];
END;
GO