---fact_pc_sales inserting primary key
   DROP TABLE PC_Sales_Staging_dtw.[dbo].[Fact_pc_sales]
   CREATE TABLE [dbo].[Fact_pc_sales](
   [PC_Sales_ID]int identity (1,1) primary key,
	[Cost_Price] [int] NOT NULL,
	[Sale_Price] [int] NOT NULL,
	[Discount_Amount] [int] NOT NULL,
	[Finance_Amount] [nvarchar](50) NOT NULL,
	[Credit_Score] [int] NOT NULL,
	[Cost_of_Repairs] [nvarchar](50) NOT NULL,
	[Total_Sales_per_Employee] [int] NOT NULL,
	[PC_Market_Price] [int] NOT NULL
    )
    ---checking if step was implemented
    SELECT * FROM PC_Sales_Staging_dtw.[dbo].[Fact_pc_sales]

  ---Inserting data into table 
  SELECT DISTINCT
       [Cost_Price]
      ,[Sale_Price]
      ,[Discount_Amount]
      ,[Finance_Amount]
      ,[Credit_Score]
      ,[Cost_of_Repairs]
      ,[Total_Sales_per_Employee]
      ,[PC_Market_Price]
   INTO [PC_Sales_Staging_dtw].[dbo].[Fact_pc_sales]
   FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

     INSERT INTO [PC_Sales_Staging_dtw].[dbo].[Fact_pc_sales](
              [Cost_Price]
             ,[Sale_Price]
             ,[Discount_Amount]
             ,[Finance_Amount]
             ,[Credit_Score]
             ,[Cost_of_Repairs]
             ,[Total_Sales_per_Employee]
             ,[PC_Market_Price])
       SELECT DISTINCT
              [Cost_Price]
             ,[Sale_Price]
             ,[Discount_Amount]
             ,[Finance_Amount]
             ,[Credit_Score]
             ,[Cost_of_Repairs]
             ,[Total_Sales_per_Employee]
             ,[PC_Market_Price]
       FROM  [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]