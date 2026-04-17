---Dim priority inserting primary key
DROP TABLE [PC_Sales_Staging_dtw].[dbo].[dim_priority] CREATE TABLE [PC_Sales_Staging_dtw].[dbo].[dim_priority](
      [Priority_ID] int identity (1, 1) primary key,
      [Priority] [nvarchar](50) NOT NULL,
      [Load_date] DATETIME DEFAULT GETDATE()
) 
---Inserting data into table 
INSERT INTO
      [PC_Sales_Staging_dtw].[dbo].[dim_priority]([Priority])
SELECT
      DISTINCT [Priority]
FROM
      [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data] 
---checking if step was implemented
SELECT
      *
FROM
      [PC_Sales_Staging_dtw].[dbo].[dim_priority]