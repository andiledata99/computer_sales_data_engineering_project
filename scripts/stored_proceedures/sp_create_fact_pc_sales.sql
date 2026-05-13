/*
=======================================================
Stored Procedure: sp_create_fact_pc_sales
Description: Creates fact_pc_sales table with foreign keys and populates data
Purpose: Store PC sales transactions and measures with dimension references
Author: Data Engineer Andile Dube
Date: 2026-05-13
=======================================================
*/

CREATE OR ALTER PROCEDURE sp_create_fact_pc_sales
AS
BEGIN

-- Fact PC Sales table creation with dimensional keys and constraints
CREATE TABLE IF NOT EXISTS [PC_Sales_Staging_dtw].[dbo].[Fact_pc_sales](
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
 
-- Insert PC sales transactions from raw data
-- Load sales measures and dimensional keys into fact table
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

-- Verification Query: Display loaded fact table records
SELECT
   *
FROM
   PC_Sales_Staging_dtw.[dbo].[Fact_pc_sales]

/*
=======================================================
Comprehensive Denormalized Query
Description: Joins fact table with all dimension tables
Purpose: Provides complete view of sales data with all attributes
Usage: Analytics and reporting
=======================================================
*/
SELECT
    f.PC_Sales_ID,
    c.Customer_Name,
    c.Customer_Surname,
    c.Customer_Contact_Number,
    c.Customer_Email_Address,
    c.Sales_Person_Name,
    c.Sales_Person_Department,
    ch.Channel,
    d.Purchase_Date,
    d.Ship_Date,
    l.Continent,
    l.Country_or_State,
    l.Province_or_City,
    p.Payment_Method,
    pr.Priority,
    s.Shop_Name,
    s.Shop_Age,
    pc.PC_Make,
    pc.PC_Model,
    pc.Storage_Type,
    pc.RAM,
    pc.Storage_Capacity,
    f.Cost_Price,
    f.Sale_Price,
    f.Discount_Amount,
    f.Finance_Amount,
    f.Credit_Score,
    f.Cost_of_Repairs,
    f.Total_Sales_per_Employee,
    f.PC_Market_Price,
    f.Load_date
FROM
    [PC_Sales_Staging_dtw].[dbo].[Fact_pc_sales] f
JOIN
    [PC_Sales_Staging_dtw].[dbo].[dim_customer] c ON f.Customer_ID = c.Customer_ID
JOIN
    [PC_Sales_Staging_dtw].[dbo].[dim_channel] ch ON f.Channel_ID = ch.Channel_ID
JOIN
    [PC_Sales_Staging_dtw].[dbo].[dim_date] d ON f.Date_ID = d.Date_ID
JOIN
    [PC_Sales_Staging_dtw].[dbo].[dim_location] l ON f.Location_ID = l.Location_ID
JOIN
    [PC_Sales_Staging_dtw].[dbo].[dim_payment] p ON f.Paymenty_ID = p.Paymenty_ID
JOIN
    [PC_Sales_Staging_dtw].[dbo].[dim_priority] pr ON f.Priority_ID = pr.Priority_ID
JOIN
    [PC_Sales_Staging_dtw].[dbo].[dim_store] s ON f.Shop_ID = s.Shop_ID
JOIN
    [PC_Sales_Staging_dtw].[dbo].[dim_pc_spec] pc ON f.PC_make_ID = pc.PC_make_ID