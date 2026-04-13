 ---Dim date inserting primary key 
   DROP TABLE PC_Sales_Staging_dtw.[dbo].[dim_date]
  CREATE TABLE [dbo].[dim_date](
    [Date_ID]int identity (1,1) primary key,
	[Purchase_Date] [datetime2](7) NOT NULL,
	[Ship_Date] [nvarchar](50) NOT NULL
    )
    ---checking if step was implemented
     SELECT * FROM PC_Sales_Staging_dtw.[dbo].[dim_date]
     
      ---Inserting data into table 
       SELECT DISTINCT
       [Purchase_Date]
      ,[Ship_Date]
  INTO [PC_Sales_Staging_dtw].[dbo].[dim_date]
  FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

  INSERT INTO  [PC_Sales_Staging_dtw].[dbo].[dim_date](
               [Purchase_Date]
              ,[Ship_Date] )
       SELECT DISTINCT 
               [Purchase_Date]
              ,[Ship_Date]
  FROM  [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]