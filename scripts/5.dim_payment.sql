 ---Dim payment inserting primary key
     DROP TABLE PC_Sales_Staging_dtw.[dbo].[dim_payment]
     CREATE TABLE [dbo].[dim_payment](
      [Paymenty_ID]int identity (1,1) primary key,
	[Payment_Method] [nvarchar](50) NOT NULL
    )
      ---checking if step was implemented
    SELECT * FROM PC_Sales_Staging_dtw.[dbo].[dim_payment]

   ---Inserting data into table 
    SELECT DISTINCT
      [Payment_Method]
 INTO [PC_Sales_Staging_dtw].[dbo].[dim_payment]
 FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

  INSERT INTO [PC_Sales_Staging_dtw].[dbo].[dim_payment](
              [Payment_Method])
       SELECT DISTINCT 
            [Payment_Method]  
  FROM  [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]
