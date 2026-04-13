 ---Dim location inserting primary key
     DROP TABLE PC_Sales_Staging_dtw.[dbo].[dim_location]
     CREATE TABLE [dbo].[dim_location](
     [Location_ID]int identity (1,1) primary key,
	[Continent] [nvarchar](50) NOT NULL,
	[Country_or_State] [nvarchar](50) NOT NULL,
	[Province_or_City] [nvarchar](100) NOT NULL
    )
    ---checking if step was implemented
    SELECT * FROM PC_Sales_Staging_dtw.[dbo].[dim_location]

    ---Inserting data into table 
      SELECT  DISTINCT 
       [Continent]
      ,[Country_or_State]
      ,[Province_or_City]
  INTO [PC_Sales_Staging_dtw].[dbo].[dim_location]
  FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

   INSERT INTO [PC_Sales_Staging_dtw].[dbo].[dim_location](
               [Continent]
              ,[Country_or_State]
              ,[Province_or_City])
       SELECT DISTINCT
               [Continent]
              ,[Country_or_State]
              ,[Province_or_City]
  FROM  [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]
