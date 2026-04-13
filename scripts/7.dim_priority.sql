 ---Dim priority inserting primary key
     DROP TABLE PC_Sales_Staging_dtw.[dbo].[dim_priority]
     CREATE TABLE [dbo].[dim_priority](
     [Priority_ID]int identity (1,1) primary key,
	[Priority] [nvarchar](50) NOT NULL
    )
     ---checking if step was implemented
    SELECT * FROM PC_Sales_Staging_dtw.[dbo].[dim_priority]

      ---Inserting data into table 
      SELECT DISTINCT 
        [Priority]
   INTO [PC_Sales_Staging_dtw].[dbo].[dim_priority]
   FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]
   
    INSERT INTO [PC_Sales_Staging_dtw].[dbo].[dim_priority](
             [Priority])
       SELECT DISTINCT
             [Priority] 
       FROM  [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]