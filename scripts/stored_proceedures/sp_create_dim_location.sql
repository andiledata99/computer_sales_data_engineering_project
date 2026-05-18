/*
=======================================================
Stored Procedure: sp_create_dim_location
Description: Creates and populates dim_location dimension
Purpose: Store geographic location information
Author: Data Engineer Andile Dube
Date: 2026-05-13
=======================================================
*/

CREATE OR ALTER PROCEDURE dbo.sp_create_dim_location
AS
BEGIN
    SET NOCOUNT ON;

    -- Dim location dimension table creation
    IF OBJECT_ID('PC_Sales_Staging_dtw.dbo.dim_location', 'U') IS NULL
    BEGIN
        CREATE TABLE [PC_Sales_Staging_dtw].[dbo].[dim_location](
            [Location_ID] int IDENTITY(1,1) PRIMARY KEY,
            [Continent] [nvarchar](50) NOT NULL,
            [Country_or_State] [nvarchar](50) NOT NULL,
            [Province_or_City] [nvarchar](100) NOT NULL,
            [Load_date] DATETIME DEFAULT GETDATE()
        );
    END;

    -- Insert distinct location records from raw data, avoid duplicates
    INSERT INTO [PC_Sales_Staging_dtw].[dbo].[dim_location](
        [Continent],
        [Country_or_State],
        [Province_or_City]
    )
    SELECT DISTINCT rd.[Continent], rd.[Country_or_State], rd.[Province_or_City]
    FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data] rd
    WHERE NOT EXISTS (
        SELECT 1 FROM [PC_Sales_Staging_dtw].[dbo].[dim_location] d
        WHERE d.Continent = rd.Continent
          AND d.Country_or_State = rd.Country_or_State
          AND d.Province_or_City = rd.Province_or_City
    );

    -- Verification Query: Display loaded location dimension records
    SELECT * FROM [PC_Sales_Staging_dtw].[dbo].[dim_location];
END;
GO