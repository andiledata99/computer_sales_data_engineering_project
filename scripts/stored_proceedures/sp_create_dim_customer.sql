CREATE PROCEDURE sp_create_fact_pc_sales
AS
BEGIN
  -- SQL_statements to be executed
---fact_pc_sales inserting primary key
DROP TABLE [PC_Sales_Staging_dtw].[dbo].[Fact_pc_sales] CREATE TABLE [PC_Sales_Staging_dtw].[dbo].[Fact_pc_sales](
   [PC_Sales_ID] int identity (1, 1) primary key,
   [Customer_ID] int,
   [Channel_ID] int,
   [Date_ID] int,
   [Location_ID] int,
   [Paymenty_ID] int,
   [Priority_ID] int,
   [Shop_ID] int,
   [PC_make_ID] int,
   [Cost_Price] [int] NOT NULL,
   [Sale_Price] [int] NOT NULL,
   [Discount_Amount] [int] NOT NULL,
   [Finance_Amount] [nvarchar](50) NOT NULL,
   [Credit_Score] [int] NOT NULL,
   [Cost_of_Repairs] [nvarchar](50) NOT NULL,
   [Total_Sales_per_Employee] [int] NOT NULL,
   [PC_Market_Price] [int] NOT NULL,
   [Load_date] DATETIME DEFAULT GETDATE(),
   Constraint fk_Customer_ID foreign key (Customer_ID) references [PC_Sales_Staging_dtw].[dbo].[dim_customer] (Customer_ID),
   Constraint fk_Channel_ID Foreign key (Channel_ID) References [PC_Sales_Staging_dtw].[dbo].[dim_Channel] (Channel_ID),
   Constraint fk_Date_ID Foreign key (Date_ID) References [PC_Sales_Staging_dtw].[dbo].[dim_Date] (Date_ID),
   Constraint fk_Location_ID Foreign key (Location_ID) References [PC_Sales_Staging_dtw].[dbo].[Dim_Location] (Location_ID),
   Constraint fk_Paymenty_ID Foreign key (Paymenty_ID) References [PC_Sales_Staging_dtw].[dbo].[dim_payment] (Paymenty_ID),
   Constraint fk_Store_ID Foreign key (Shop_ID) References [PC_Sales_Staging_dtw].[dbo].[dim_Store] (Shop_ID),
   Constraint fk_Priority_ID Foreign key (Priority_ID) References [PC_Sales_Staging_dtw].[dbo].[dim_Priority] (Priority_ID),
   Constraint fk_PC_make_ID Foreign key (PC_make_ID) References [PC_Sales_Staging_dtw].[dbo].[dim_pc_spec] (PC_make_ID)
)
 ---Inserting data into table 
INSERT INTO
   [PC_Sales_Staging_dtw].[dbo].[Fact_pc_sales](
      [Cost_Price],
      [Sale_Price],
      [Discount_Amount],
      [Finance_Amount],
      [Credit_Score],
      [Cost_of_Repairs],
      [Total_Sales_per_Employee],
      [PC_Market_Price]
   )
SELECT
   DISTINCT [Cost_Price],
   [Sale_Price],
   [Discount_Amount],
   [Finance_Amount],
   [Credit_Score],
   [Cost_of_Repairs],
   [Total_Sales_per_Employee],
   [PC_Market_Price]
FROM
   [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data] 
---checking if step was implemented
SELECT
   *
FROM
   PC_Sales_Staging_dtw.[dbo].[Fact_pc_sales]
   END;
