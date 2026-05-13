/*
=======================================================
Script: 4.dim_location.sql
Description: Creates and populates dim_location dimension table
Purpose: Store geographic location information
Author: Data Engineering Team
Date: 2026-05-13
=======================================================
*/

CREATE TABLE IF NOT EXISTS [PC_Sales_Staging_dtw].[dbo].[dim_location](
     [Location_ID] int identity (1, 1) primary key,
     [Continent] [nvarchar](50) NOT NULL,
     [Country_or_State] [nvarchar](50) NOT NULL,
     [Province_or_City] [nvarchar](100) NOT NULL,
     [Load_date] DATETIME DEFAULT GETDATE()
)

-- Insert distinct location records from raw data
INSERT INTO
     [PC_Sales_Staging_dtw].[dbo].[dim_location](
          [Continent],
          [Country_or_State],
          [Province_or_City]
     )
SELECT
     DISTINCT [Continent],
     [Country_or_State],
     [Province_or_City]
FROM
     [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

-- Verification Query: Display loaded location dimension records
SELECT
     *
FROM
     [PC_Sales_Staging_dtw].[dbo].[dim_location]