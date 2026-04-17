-------------------------Creating Dim_Tables and Fact_Table
 
--Dim_location
--Data normalization 
SELECT  DISTINCT 
       [Continent]
      ,[Country_or_State]
      ,[Province_or_City]
  FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

  ---Inserting dim_table into database 

  SELECT  DISTINCT 
       [Continent]
      ,[Country_or_State]
      ,[Province_or_City]
  INTO [PC_Sales_Staging_dtw].[dbo].[dim_location]
  FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]
   
  --Dim_priority
  --Data normalization 
   SELECT DISTINCT 
        [Priority]
   FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

---Inserting dim table into database 
 SELECT DISTINCT 
        [Priority]
   INTO [PC_Sales_Staging_dtw].[dbo].[dim_priority]
   FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

---Dim_payment
--Data normalization
SELECT DISTINCT
      [Payment_Method]
 FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

 ---Inserting dim table into database
 SELECT DISTINCT
      [Payment_Method]
 INTO [PC_Sales_Staging_dtw].[dbo].[dim_payment]
 FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

 ---Dim_store
 --Data normalization
 SELECT DISTINCT
       [Shop_Name]
      ,[Shop_Age]
  FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

  ---Inserting dim table into database
   SELECT DISTINCT
       [Shop_Name]
      ,[Shop_Age]
  INTO [PC_Sales_Staging_dtw].[dbo].[dim_store]
  FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

  ---Dim_date
  --Data normalization
  SELECT DISTINCT
       [Purchase_Date]
      ,[Ship_Date]
  FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

  ---Inserting dim table into database
    SELECT DISTINCT
       [Purchase_Date]
      ,[Ship_Date]
  INTO [PC_Sales_Staging_dtw].[dbo].[dim_date]
  FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

  ---Dim_customer
   --Data normalization
  SELECT DISTINCT
       [Customer_Name]
      ,[Customer_Surname]
      ,[Customer_Contact_Number]
      ,[Customer_Email_Address]
      ,[Sales_Person_Name]
      ,[Sales_Person_Department]
   FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

   ---Inserting dim table into database
  SELECT DISTINCT
       [Customer_Name]
      ,[Customer_Surname]
      ,[Customer_Contact_Number]
      ,[Customer_Email_Address]
      ,[Sales_Person_Name]
      ,[Sales_Person_Department]
   INTO  [PC_Sales_Staging_dtw].[dbo].[dim_customer]
   FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

   ---Dim_pc_spec
    --Data normalization
 SELECT DISTINCT 
       [PC_Make]
      ,[PC_Model]
      ,[Storage_Type]
      ,[RAM]
      ,[Storage_Capacity]
 FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

  ---Inserting dim table into database
SELECT DISTINCT 
       [PC_Make]
      ,[PC_Model]
      ,[Storage_Type]
      ,[RAM]
      ,[Storage_Capacity]
 INTO [PC_Sales_Staging_dtw].[dbo].[dim_pc_spec]
 FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]


 ---Dim_channel
  --Data normalization
  SELECT DISTINCT
       [Channel]
  FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

   ---Inserting dim table into database
  SELECT DISTINCT
       [Channel]
  INTO [PC_Sales_Staging_dtw].[dbo].[dim_channel]
  FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

   
------------Fact_table 
--Fact_PC_Sales
  --Data normalization
  SELECT DISTINCT
        [Cost_Price]
      ,[Sale_Price]
      ,[Discount_Amount]
      ,[Finance_Amount]
      ,[Credit_Score]
      ,[Cost_of_Repairs]
      ,[Total_Sales_per_Employee]
      ,[PC_Market_Price]
   FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

    ---Inserting fact table into database
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

 