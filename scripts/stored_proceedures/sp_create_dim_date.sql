/*
=======================================================
Stored Procedure: sp_create_dim_date
Description: Creates and populates dim_date dimension
Purpose: Store purchase and shipment date information
Author: Data Engineering Team
Date: 2026-05-13
=======================================================
*/

CREATE OR ALTER PROCEDURE sp_create_dim_date
AS
BEGIN
  -- SQL statements to be executed
 -- Dim date dimension table creation
CREATE TABLE IF NOT EXISTS [PC_Sales_Staging_dtw].[dbo].[dim_date](
  [Date_ID] int identity (1, 1) primary key,
  [Purchase_Date] [datetime2](7) NOT NULL,
  [Ship_Date] [nvarchar](50) NOT NULL,
  [Load_date] DATETIME DEFAULT GETDATE()
)
 
-- Insert distinct date records from raw data
INSERT INTO
  [PC_Sales_Staging_dtw].[dbo].[dim_date](
    [Purchase_Date],
    [Ship_Date]
  )
SELECT
  DISTINCT [Purchase_Date],
  [Ship_Date]
FROM
  [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data] 

-- Verification Query: Display loaded date dimension records
SELECT
  *
FROM
  [PC_Sales_Staging_dtw].[dbo].[dim_date]
END;