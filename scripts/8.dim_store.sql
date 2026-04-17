---Dim store inserting primary key
     DROP TABLE  [PC_Sales_Staging_dtw].[dbo].[dim_store]
     CREATE TABLE [PC_Sales_Staging_dtw].[dbo].[dim_store](
     [Shop_ID]int identity (1,1) primary key,
	[Shop_Name] [nvarchar](50) NOT NULL,
	[Shop_Age] [nvarchar](50) NOT NULL,
    [Load_date] DATETIME DEFAULT GETDATE()
)

  ---Inserting data into table 
      
    INSERT INTO [PC_Sales_Staging_dtw].[dbo].[dim_store](
             [Shop_Name]
            ,[Shop_Age])
       SELECT DISTINCT
             [Shop_Name]
            ,[Shop_Age]
       FROM  [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

        ---checking if step was implemented
    SELECT * FROM [PC_Sales_Staging_dtw].[dbo].[dim_store]

