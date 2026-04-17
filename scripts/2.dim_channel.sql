 ---Dim channel inserting primary key 
  DROP TABLE [PC_Sales_Staging_dtw].[dbo].[dim_channel]
  CREATE TABLE [PC_Sales_Staging_dtw].[dbo].[dim_channel](
    [Channel_ID]int identity (1,1) primary key,
	[Channel] [nvarchar](50) NOT NULL,
    [Load_date] DATETIME DEFAULT GETDATE()
    )
  
     ---Inserting data into table 

  INSERT INTO  [PC_Sales_Staging_dtw].[dbo].[dim_channel](
               [Channel])
  SELECT DISTINCT 
        [Channel]
  FROM  [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data] 

    ---checking if step was implemented
    SELECT * FROM [PC_Sales_Staging_dtw].[dbo].[dim_channel]