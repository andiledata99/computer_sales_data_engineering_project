/*
=======================================================
Stored Procedure: sp_create_dim_store
Description: Creates and populates dim_store dimension
Purpose: Store store information
Author: Data Engineer Andile Dube
Date: 2026-05-13
=======================================================
*/

CREATE OR ALTER PROCEDURE sp_create_dim_store
AS
BEGIN
  -- SQL statements to be executed
 -- Dim store dimension table creation
CREATE TABLE IF NOT EXISTS [PC_Sales_Staging_dtw].[dbo].[dim_store](
     [Shop_ID] int identity (1, 1) primary key,
     [Shop_Name] [nvarchar](50) NOT NULL,
     [Shop_Age] [nvarchar](50) NOT NULL,
     [Load_date] DATETIME DEFAULT GETDATE()
)
 
-- Insert distinct store records from raw data
INSERT INTO
     [PC_Sales_Staging_dtw].[dbo].[dim_store](
          [Shop_Name],
          [Shop_Age]
     )
SELECT
     DISTINCT [Shop_Name],
     [Shop_Age]
FROM
     [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data] 

-- Verification Query: Display loaded store dimension records
SELECT
     *
FROM
     [PC_Sales_Staging_dtw].[dbo].[dim_store]
END;