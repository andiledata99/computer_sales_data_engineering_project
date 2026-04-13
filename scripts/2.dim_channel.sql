 ---Dim channel inserting primary key 
  DROP TABLE PC_Sales_Staging_dtw.[dbo].[dim_channel]
  CREATE TABLE [dbo].[dim_channel](
    [Channel_ID]int identity (1,1) primary key,
	[Channel] [nvarchar](50) NOT NULL
    )
    ---checking if step was implemented
    SELECT * FROM PC_Sales_Staging_dtw.[dbo].[dim_channel]

     ---Inserting data into table 
     SELECT DISTINCT
       [Channel]
  INTO [PC_Sales_Staging_dtw].[dbo].[dim_channel]
  FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

  INSERT INTO  [PC_Sales_Staging_dtw].[dbo].[dim_channel](
               [Channel])
  SELECT DISTINCT 
        [Channel]
  FROM  [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data] 