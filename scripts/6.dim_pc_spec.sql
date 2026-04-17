---Dim pc spec inserting primary key
DROP TABLE [PC_Sales_Staging_dtw].[dbo].[dim_pc_spec] CREATE TABLE [PC_Sales_Staging_dtw].[dbo].[dim_pc_spec](
  [PC_make_ID] int identity (1, 1) primary key,
  [PC_Make] [nvarchar](50) NOT NULL,
  [PC_Model] [nvarchar](50) NOT NULL,
  [Storage_Type] [nvarchar](50) NOT NULL,
  [RAM] [nvarchar](50) NOT NULL,
  [Storage_Capacity] [nvarchar](50) NOT NULL,
  [Load_date] DATETIME DEFAULT GETDATE()
) 
---Inserting data into table 
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
---checking if step was implemented
SELECT
  *
FROM
  [PC_Sales_Staging_dtw].[dbo].[dim_pc_spec] 