/*
=======================================================
Script: 7.dim_priority.sql
Description: Creates and populates dim_priority dimension table
Purpose: Store priority level information
Author: Data Engineer Andile Dube
Date: 2026-05-14
=======================================================
*/

CREATE TABLE IF NOT EXISTS [PC_Sales_Staging_dtw].[dbo].[dim_priority](
      [Priority_ID] int identity (1, 1) primary key,
      [Priority] [nvarchar](50) NOT NULL,
      [Load_date] DATETIME DEFAULT GETDATE()
)

-- Insert distinct priority records from raw data
INSERT INTO
      [PC_Sales_Staging_dtw].[dbo].[dim_priority]([Priority])
SELECT
      DISTINCT [Priority]
FROM
      [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

-- Verification Query: Display loaded priority dimension records
SELECT
      *
FROM
      [PC_Sales_Staging_dtw].[dbo].[dim_priority]