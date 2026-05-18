/*
=======================================================
Stored Procedure: sp_load_cleaned_dim_and_fact_data
Description: Loads dimensions and fact table from validated cleaned raw data
Purpose: Build production-grade dimension and fact tables from clean staging data
Author: Data Engineer Andile Dube
Date: 2026-05-14
=======================================================
*/

CREATE OR ALTER PROCEDURE dbo.sp_load_cleaned_dim_and_fact_data
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('PC_Sales_Staging_dtw.dbo.dim_channel', 'U') IS NOT NULL
    BEGIN
        DROP TABLE PC_Sales_Staging_dtw.dbo.dim_channel;
    END;
    CREATE TABLE PC_Sales_Staging_dtw.dbo.dim_channel(
        Channel_ID int IDENTITY(1,1) PRIMARY KEY,
        [Channel] nvarchar(50) NOT NULL,
        Load_date datetime DEFAULT GETDATE()
    );
    INSERT INTO PC_Sales_Staging_dtw.dbo.dim_channel([Channel])
    SELECT DISTINCT [Channel]
    FROM PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Cleaned;

    IF OBJECT_ID('PC_Sales_Staging_dtw.dbo.dim_customer', 'U') IS NOT NULL
    BEGIN
        DROP TABLE PC_Sales_Staging_dtw.dbo.dim_customer;
    END;
    CREATE TABLE PC_Sales_Staging_dtw.dbo.dim_customer(
        Customer_ID int IDENTITY(1,1) PRIMARY KEY,
        Customer_Name nvarchar(50) NOT NULL,
        Customer_Surname nvarchar(50) NOT NULL,
        Customer_Contact_Number nvarchar(50) NOT NULL,
        Customer_Email_Address nvarchar(100) NOT NULL,
        Sales_Person_Name nvarchar(50) NOT NULL,
        Sales_Person_Department nvarchar(50) NOT NULL,
        Load_date datetime DEFAULT GETDATE()
    );
    INSERT INTO PC_Sales_Staging_dtw.dbo.dim_customer(
        Customer_Name,
        Customer_Surname,
        Customer_Contact_Number,
        Customer_Email_Address,
        Sales_Person_Name,
        Sales_Person_Department
    )
    SELECT DISTINCT
        Customer_Name,
        Customer_Surname,
        Customer_Contact_Number,
        Customer_Email_Address,
        Sales_Person_Name,
        Sales_Person_Department
    FROM PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Cleaned;

    IF OBJECT_ID('PC_Sales_Staging_dtw.dbo.dim_date', 'U') IS NOT NULL
    BEGIN
        DROP TABLE PC_Sales_Staging_dtw.dbo.dim_date;
    END;
    CREATE TABLE PC_Sales_Staging_dtw.dbo.dim_date(
        Date_ID int IDENTITY(1,1) PRIMARY KEY,
        Purchase_Date date NOT NULL,
        Ship_Date date NULL,
        Load_date datetime DEFAULT GETDATE()
    );
    INSERT INTO PC_Sales_Staging_dtw.dbo.dim_date(Purchase_Date, Ship_Date)
    SELECT DISTINCT Purchase_Date, Ship_Date
    FROM PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Cleaned;

    IF OBJECT_ID('PC_Sales_Staging_dtw.dbo.dim_location', 'U') IS NOT NULL
    BEGIN
        DROP TABLE PC_Sales_Staging_dtw.dbo.dim_location;
    END;
    CREATE TABLE PC_Sales_Staging_dtw.dbo.dim_location(
        Location_ID int IDENTITY(1,1) PRIMARY KEY,
        Continent nvarchar(50) NOT NULL,
        Country_or_State nvarchar(50) NOT NULL,
        Province_or_City nvarchar(100) NOT NULL,
        Load_date datetime DEFAULT GETDATE()
    );
    INSERT INTO PC_Sales_Staging_dtw.dbo.dim_location(
        Continent,
        Country_or_State,
        Province_or_City
    )
    SELECT DISTINCT
        Continent,
        Country_or_State,
        Province_or_City
    FROM PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Cleaned;

    IF OBJECT_ID('PC_Sales_Staging_dtw.dbo.dim_payment', 'U') IS NOT NULL
    BEGIN
        DROP TABLE PC_Sales_Staging_dtw.dbo.dim_payment;
    END;
    CREATE TABLE PC_Sales_Staging_dtw.dbo.dim_payment(
        Paymenty_ID int IDENTITY(1,1) PRIMARY KEY,
        Payment_Method nvarchar(50) NOT NULL,
        Load_date datetime DEFAULT GETDATE()
    );
    INSERT INTO PC_Sales_Staging_dtw.dbo.dim_payment(Payment_Method)
    SELECT DISTINCT Payment_Method
    FROM PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Cleaned;

    IF OBJECT_ID('PC_Sales_Staging_dtw.dbo.dim_priority', 'U') IS NOT NULL
    BEGIN
        DROP TABLE PC_Sales_Staging_dtw.dbo.dim_priority;
    END;
    CREATE TABLE PC_Sales_Staging_dtw.dbo.dim_priority(
        Priority_ID int IDENTITY(1,1) PRIMARY KEY,
        Priority nvarchar(50) NOT NULL,
        Load_date datetime DEFAULT GETDATE()
    );
    INSERT INTO PC_Sales_Staging_dtw.dbo.dim_priority(Priority)
    SELECT DISTINCT Priority
    FROM PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Cleaned;

    IF OBJECT_ID('PC_Sales_Staging_dtw.dbo.dim_store', 'U') IS NOT NULL
    BEGIN
        DROP TABLE PC_Sales_Staging_dtw.dbo.dim_store;
    END;
    CREATE TABLE PC_Sales_Staging_dtw.dbo.dim_store(
        Shop_ID int IDENTITY(1,1) PRIMARY KEY,
        Shop_Name nvarchar(100) NOT NULL,
        Shop_Age int NOT NULL,
        Load_date datetime DEFAULT GETDATE()
    );
    INSERT INTO PC_Sales_Staging_dtw.dbo.dim_store(Shop_Name, Shop_Age)
    SELECT DISTINCT Shop_Name, Shop_Age
    FROM PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Cleaned;

    IF OBJECT_ID('PC_Sales_Staging_dtw.dbo.dim_pc_spec', 'U') IS NOT NULL
    BEGIN
        DROP TABLE PC_Sales_Staging_dtw.dbo.dim_pc_spec;
    END;
    CREATE TABLE PC_Sales_Staging_dtw.dbo.dim_pc_spec(
        PC_make_ID int IDENTITY(1,1) PRIMARY KEY,
        PC_Make nvarchar(50) NOT NULL,
        PC_Model nvarchar(50) NOT NULL,
        Storage_Type nvarchar(20) NOT NULL,
        RAM nvarchar(20) NOT NULL,
        Storage_Capacity nvarchar(50) NOT NULL,
        Load_date datetime DEFAULT GETDATE()
    );
    INSERT INTO PC_Sales_Staging_dtw.dbo.dim_pc_spec(
        PC_Make,
        PC_Model,
        Storage_Type,
        RAM,
        Storage_Capacity
    )
    SELECT DISTINCT
        PC_Make,
        PC_Model,
        Storage_Type,
        RAM,
        Storage_Capacity
    FROM PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Cleaned;

    IF OBJECT_ID('PC_Sales_Staging_dtw.dbo.Fact_pc_sales', 'U') IS NOT NULL
    BEGIN
        DROP TABLE PC_Sales_Staging_dtw.dbo.Fact_pc_sales;
    END;
    CREATE TABLE PC_Sales_Staging_dtw.dbo.Fact_pc_sales(
        PC_Sales_ID int IDENTITY(1,1) PRIMARY KEY,
        Customer_ID int NULL,
        Channel_ID int NULL,
        Date_ID int NULL,
        Location_ID int NULL,
        Paymenty_ID int NULL,
        Priority_ID int NULL,
        Shop_ID int NULL,
        PC_make_ID int NULL,
        Cost_Price decimal(18,2) NOT NULL,
        Sale_Price decimal(18,2) NOT NULL,
        Discount_Amount decimal(18,2) NOT NULL,
        Finance_Amount decimal(18,2) NOT NULL,
        Credit_Score int NOT NULL,
        Cost_of_Repairs decimal(18,2) NOT NULL,
        Total_Sales_per_Employee decimal(18,2) NOT NULL,
        PC_Market_Price decimal(18,2) NOT NULL,
        Load_date datetime DEFAULT GETDATE(),
        CONSTRAINT fk_Customer_ID FOREIGN KEY (Customer_ID) REFERENCES PC_Sales_Staging_dtw.dbo.dim_customer(Customer_ID),
        CONSTRAINT fk_Channel_ID FOREIGN KEY (Channel_ID) REFERENCES PC_Sales_Staging_dtw.dbo.dim_channel(Channel_ID),
        CONSTRAINT fk_Date_ID FOREIGN KEY (Date_ID) REFERENCES PC_Sales_Staging_dtw.dbo.dim_date(Date_ID),
        CONSTRAINT fk_Location_ID FOREIGN KEY (Location_ID) REFERENCES PC_Sales_Staging_dtw.dbo.dim_location(Location_ID),
        CONSTRAINT fk_Paymenty_ID FOREIGN KEY (Paymenty_ID) REFERENCES PC_Sales_Staging_dtw.dbo.dim_payment(Paymenty_ID),
        CONSTRAINT fk_Store_ID FOREIGN KEY (Shop_ID) REFERENCES PC_Sales_Staging_dtw.dbo.dim_store(Shop_ID),
        CONSTRAINT fk_Priority_ID FOREIGN KEY (Priority_ID) REFERENCES PC_Sales_Staging_dtw.dbo.dim_priority(Priority_ID),
        CONSTRAINT fk_PC_make_ID FOREIGN KEY (PC_make_ID) REFERENCES PC_Sales_Staging_dtw.dbo.dim_pc_spec(PC_make_ID)
    );

    INSERT INTO PC_Sales_Staging_dtw.dbo.Fact_pc_sales(
        Customer_ID,
        Channel_ID,
        Date_ID,
        Location_ID,
        Paymenty_ID,
        Priority_ID,
        Shop_ID,
        PC_make_ID,
        Cost_Price,
        Sale_Price,
        Discount_Amount,
        Finance_Amount,
        Credit_Score,
        Cost_of_Repairs,
        Total_Sales_per_Employee,
        PC_Market_Price
    )
    SELECT
        c.Customer_ID,
        ch.Channel_ID,
        d.Date_ID,
        l.Location_ID,
        p.Paymenty_ID,
        pr.Priority_ID,
        s.Shop_ID,
        pc.PC_make_ID,
        r.Cost_Price,
        r.Sale_Price,
        r.Discount_Amount,
        r.Finance_Amount,
        r.Credit_Score,
        r.Cost_of_Repairs,
        r.Total_Sales_per_Employee,
        r.PC_Market_Price
    FROM PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Cleaned r
    JOIN PC_Sales_Staging_dtw.dbo.dim_customer c
        ON r.Customer_Name = c.Customer_Name
        AND r.Customer_Surname = c.Customer_Surname
        AND r.Customer_Contact_Number = c.Customer_Contact_Number
        AND r.Customer_Email_Address = c.Customer_Email_Address
    JOIN PC_Sales_Staging_dtw.dbo.dim_channel ch
        ON r.Channel = ch.Channel
    JOIN PC_Sales_Staging_dtw.dbo.dim_date d
        ON r.Purchase_Date = d.Purchase_Date
        AND (r.Ship_Date = d.Ship_Date OR (r.Ship_Date IS NULL AND d.Ship_Date IS NULL))
    JOIN PC_Sales_Staging_dtw.dbo.dim_location l
        ON r.Continent = l.Continent
        AND r.Country_or_State = l.Country_or_State
        AND r.Province_or_City = l.Province_or_City
    JOIN PC_Sales_Staging_dtw.dbo.dim_payment p
        ON r.Payment_Method = p.Payment_Method
    JOIN PC_Sales_Staging_dtw.dbo.dim_priority pr
        ON r.Priority = pr.Priority
    JOIN PC_Sales_Staging_dtw.dbo.dim_store s
        ON r.Shop_Name = s.Shop_Name
        AND r.Shop_Age = s.Shop_Age
    JOIN PC_Sales_Staging_dtw.dbo.dim_pc_spec pc
        ON r.PC_Make = pc.PC_Make
        AND r.PC_Model = pc.PC_Model
        AND r.Storage_Type = pc.Storage_Type
        AND r.RAM = pc.RAM
        AND r.Storage_Capacity = pc.Storage_Capacity;

    SELECT
        (SELECT COUNT(*) FROM PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Cleaned) AS LoadedCleanRows,
        (SELECT COUNT(*) FROM PC_Sales_Staging_dtw.dbo.Fact_pc_sales) AS LoadedFactRows;
END;
GO
