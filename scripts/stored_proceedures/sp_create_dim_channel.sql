

/*
=======================================================
Stored Procedure: sp_create_dim_channel
Description: Creates and populates dim_channel dimension
Purpose: Store sales channel information
Author: Data Engineering Team
Date: 2026-05-13
=======================================================
*/

CREATE OR ALTER PROCEDURE sp_create_dim_channel
AS
BEGIN
  -- SQL statements to be executed
 -- Dim channel dimension table creation
CREATE TABLE IF NOT EXISTS [PC_Sales_Staging_dtw].[dbo].[dim_channel](
  [Channel_ID] int identity (1, 1) primary key,
  [Channel] [nvarchar](50) NOT NULL,
  [Load_date] DATETIME DEFAULT GETDATE()
)
 
-- Insert distinct channel records from raw data
INSERT INTO
  [PC_Sales_Staging_dtw].[dbo].[dim_channel]([Channel])
SELECT
  DISTINCT [Channel]
FROM
  [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data] 

-- Verification Query: Display loaded channel dimension records
SELECT
  *
FROM
  [PC_Sales_Staging_dtw].[dbo].[dim_channel]
END;