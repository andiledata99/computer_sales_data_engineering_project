/*
=======================================================
Stored Procedure: sp_create_dim_pc_spec
Description: Creates and populates dim_pc_spec dimension
Purpose: Store PC specification information
Author: Data Engineer Andile Dube
Date: 2026-05-13
=======================================================
*/

CREATE OR ALTER PROCEDURE sp_create_dim_pc_spec
AS
BEGIN
  -- SQL statements to be executed
 -- Dim pc spec dimension table creation
CREATE TABLE IF NOT EXISTS [PC_Sales_Staging_dtw].[dbo].[dim_pc_spec](
  [PC_make_ID] int identity (1, 1) primary key,
  [PC_Make] [nvarchar](50) NOT NULL,
  [PC_Model] [nvarchar](50) NOT NULL,
  [Storage_Type] [nvarchar](50) NOT NULL,
  [RAM] [nvarchar](50) NOT NULL,
  [Storage_Capacity] [nvarchar](50) NOT NULL,
  [Load_date] DATETIME DEFAULT GETDATE()
)
 
-- Insert distinct PC specification records from raw data
INSERT INTO
  [PC_Sales_Staging_dtw].[dbo].[dim_pc_spec](
    [PC_Make],
    [PC_Model],
    [Storage_Type],
    [RAM],
    [Storage_Capacity]
  )
SELECT
  DISTINCT [PC_Make],
  [PC_Model],
  [Storage_Type],
  [RAM],
  [Storage_Capacity]
FROM
  [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data] 

-- Verification Query: Display loaded PC specification dimension records
SELECT
  *
FROM
  [PC_Sales_Staging_dtw].[dbo].[dim_pc_spec]
END;