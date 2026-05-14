/*
=======================================================
Stored Procedure: sp_validate_and_clean_raw_pc_data
Description: Validates and cleans raw PC sales staging data
Purpose: Create cleaned and validated staging data for downstream load
Author: Data Engineer Andile Dube
Date: 2026-05-14
=======================================================
*/

CREATE OR ALTER PROCEDURE sp_validate_and_clean_raw_pc_data
AS
BEGIN
    SET NOCOUNT ON;

    IF OBJECT_ID('PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Validation', 'U') IS NOT NULL
    BEGIN
        DROP TABLE PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Validation;
    END;

    CREATE TABLE PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Validation(
        [Continent] [nvarchar](50),
        [Country_or_State] [nvarchar](50),
        [Province_or_City] [nvarchar](100),
        [Shop_Name] [nvarchar](100),
        [Shop_Age] int,
        [PC_Make] [nvarchar](50),
        [PC_Model] [nvarchar](50),
        [Storage_Type] [nvarchar](20),
        [Customer_Name] [nvarchar](50),
        [Customer_Surname] [nvarchar](50),
        [Customer_Contact_Number] [nvarchar](50),
        [Customer_Email_Address] [nvarchar](100),
        [Sales_Person_Name] [nvarchar](50),
        [Sales_Person_Department] [nvarchar](50),
        [Cost_Price] decimal(18,2),
        [Sale_Price] decimal(18,2),
        [Payment_Method] [nvarchar](50),
        [Discount_Amount] decimal(18,2),
        [Purchase_Date] date,
        [Ship_Date] date NULL,
        [Finance_Amount] decimal(18,2),
        [RAM] [nvarchar](20),
        [Credit_Score] int,
        [Channel] [nvarchar](20),
        [Priority] [nvarchar](20),
        [Cost_of_Repairs] decimal(18,2),
        [Total_Sales_per_Employee] decimal(18,2),
        [PC_Market_Price] decimal(18,2),
        [Storage_Capacity] [nvarchar](50),
        [Validation_Status] [nvarchar](10),
        [Validation_Error] [nvarchar](250),
        [Load_Date] datetime DEFAULT GETDATE()
    );

    INSERT INTO PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Validation(
        [Continent],
        [Country_or_State],
        [Province_or_City],
        [Shop_Name],
        [Shop_Age],
        [PC_Make],
        [PC_Model],
        [Storage_Type],
        [Customer_Name],
        [Customer_Surname],
        [Customer_Contact_Number],
        [Customer_Email_Address],
        [Sales_Person_Name],
        [Sales_Person_Department],
        [Cost_Price],
        [Sale_Price],
        [Payment_Method],
        [Discount_Amount],
        [Purchase_Date],
        [Ship_Date],
        [Finance_Amount],
        [RAM],
        [Credit_Score],
        [Channel],
        [Priority],
        [Cost_of_Repairs],
        [Total_Sales_per_Employee],
        [PC_Market_Price],
        [Storage_Capacity],
        [Validation_Status],
        [Validation_Error]
    )
    SELECT
        NULLIF(LTRIM(RTRIM([Continent])), ''),
        NULLIF(LTRIM(RTRIM([Country or State])), ''),
        NULLIF(LTRIM(RTRIM([Province or City])), ''),
        NULLIF(LTRIM(RTRIM([Shop Name])), ''),
        TRY_CAST(NULLIF(LTRIM(RTRIM([Shop Age])), '') AS int),
        NULLIF(LTRIM(RTRIM([PC Make])), ''),
        NULLIF(LTRIM(RTRIM([PC Model])), ''),
        CASE
            WHEN UPPER(LTRIM(RTRIM([Storage Type]))) IN ('SSD','HDD') THEN UPPER(LTRIM(RTRIM([Storage Type])))
            ELSE NULL
        END,
        NULLIF(LTRIM(RTRIM([Customer Name])), ''),
        NULLIF(LTRIM(RTRIM([Customer Surname])), ''),
        NULLIF(LTRIM(RTRIM([Customer Contact Number])), ''),
        NULLIF(LTRIM(RTRIM([Customer Email Address])), ''),
        NULLIF(LTRIM(RTRIM([Sales Person Name])), ''),
        NULLIF(LTRIM(RTRIM([Sales Person Department])), ''),
        TRY_CAST(REPLACE(NULLIF(LTRIM(RTRIM([Cost Price])), ''), ',', '') AS decimal(18,2)),
        TRY_CAST(REPLACE(NULLIF(LTRIM(RTRIM([Sale Price])), ''), ',', '') AS decimal(18,2)),
        CASE
            WHEN UPPER(LTRIM(RTRIM([Payment Method]))) IN ('CASH') THEN 'Cash'
            WHEN UPPER(LTRIM(RTRIM([Payment Method]))) IN ('FINANCE','FINANCING') THEN 'Finance'
            WHEN UPPER(LTRIM(RTRIM([Payment Method]))) IN ('BANK TRANSFER','BANKTRANSFER') THEN 'Bank Transfer'
            ELSE NULL
        END,
        TRY_CAST(REPLACE(NULLIF(LTRIM(RTRIM([Discount Amount])), ''), ',', '') AS decimal(18,2)),
        TRY_CONVERT(date, NULLIF(LTRIM(RTRIM([Purchase Date])), '')),
        CASE
            WHEN UPPER(LTRIM(RTRIM([Ship Date]))) IN ('N/A','NA','') THEN NULL
            ELSE TRY_CONVERT(date, NULLIF(LTRIM(RTRIM([Ship Date])), ''))
        END,
        TRY_CAST(REPLACE(NULLIF(LTRIM(RTRIM([Finance Amount])), ''), ',', '') AS decimal(18,2)),
        CASE
            WHEN PATINDEX('%[0-9]GB%', UPPER(LTRIM(RTRIM([RAM])))) > 0 THEN UPPER(LTRIM(RTRIM([RAM])))
            ELSE NULL
        END,
        TRY_CAST(NULLIF(LTRIM(RTRIM([Credit Score])), '') AS int),
        CASE
            WHEN UPPER(LTRIM(RTRIM([Channel]))) IN ('ONLINE','OFFLINE') THEN UPPER(LTRIM(RTRIM([Channel])))
            ELSE NULL
        END,
        CASE
            WHEN UPPER(LTRIM(RTRIM([Priority]))) IN ('LOW','MEDIUM','HIGH') THEN UPPER(LTRIM(RTRIM([Priority])))
            ELSE NULL
        END,
        TRY_CAST(REPLACE(NULLIF(LTRIM(RTRIM([Cost of Repairs])), ''), ',', '') AS decimal(18,2)),
        TRY_CAST(REPLACE(NULLIF(LTRIM(RTRIM([Total Sales per Employee])), ''), ',', '') AS decimal(18,2)),
        TRY_CAST(REPLACE(NULLIF(LTRIM(RTRIM([PC Market Price])), ''), ',', '') AS decimal(18,2)),
        NULLIF(LTRIM(RTRIM([Storage Capacity])), ''),
        CASE
            WHEN LEN(NULLIF(LTRIM(RTRIM([Continent])), '')) = 0 THEN 'FAIL'
            WHEN LEN(NULLIF(LTRIM(RTRIM([Country or State])), '')) = 0 THEN 'FAIL'
            WHEN LEN(NULLIF(LTRIM(RTRIM([Province or City])), '')) = 0 THEN 'FAIL'
            WHEN LEN(NULLIF(LTRIM(RTRIM([Shop Name])), '')) = 0 THEN 'FAIL'
            WHEN TRY_CAST(NULLIF(LTRIM(RTRIM([Shop Age])), '') AS int) IS NULL THEN 'FAIL'
            WHEN LEN(NULLIF(LTRIM(RTRIM([PC Make])), '')) = 0 THEN 'FAIL'
            WHEN LEN(NULLIF(LTRIM(RTRIM([PC Model])), '')) = 0 THEN 'FAIL'
            WHEN CASE WHEN UPPER(LTRIM(RTRIM([Storage Type]))) IN ('SSD','HDD') THEN 1 ELSE 0 END = 0 THEN 'FAIL'
            WHEN LEN(NULLIF(LTRIM(RTRIM([Customer Name])), '')) = 0 THEN 'FAIL'
            WHEN LEN(NULLIF(LTRIM(RTRIM([Customer Surname])), '')) = 0 THEN 'FAIL'
            WHEN LEN(NULLIF(LTRIM(RTRIM([Customer Email Address])), '')) = 0 THEN 'FAIL'
            WHEN CHARINDEX('@', NULLIF(LTRIM(RTRIM([Customer Email Address])), '')) = 0 THEN 'FAIL'
            WHEN TRY_CAST(REPLACE(NULLIF(LTRIM(RTRIM([Cost Price])), ''), ',', '') AS decimal(18,2)) IS NULL THEN 'FAIL'
            WHEN TRY_CAST(REPLACE(NULLIF(LTRIM(RTRIM([Sale Price])), ''), ',', '') AS decimal(18,2)) IS NULL THEN 'FAIL'
            WHEN CASE WHEN UPPER(LTRIM(RTRIM([Payment Method]))) IN ('CASH','FINANCE','FINANCING','BANK TRANSFER','BANKTRANSFER') THEN 1 ELSE 0 END = 0 THEN 'FAIL'
            WHEN TRY_CAST(REPLACE(NULLIF(LTRIM(RTRIM([Discount Amount])), ''), ',', '') AS decimal(18,2)) IS NULL THEN 'FAIL'
            WHEN TRY_CONVERT(date, NULLIF(LTRIM(RTRIM([Purchase Date])), '')) IS NULL THEN 'FAIL'
            WHEN UPPER(LTRIM(RTRIM([Ship Date]))) NOT IN ('N/A','NA','') AND TRY_CONVERT(date, NULLIF(LTRIM(RTRIM([Ship Date])), '')) IS NULL THEN 'FAIL'
            WHEN TRY_CAST(REPLACE(NULLIF(LTRIM(RTRIM([Finance Amount])), ''), ',', '') AS decimal(18,2)) IS NULL THEN 'FAIL'
            WHEN PATINDEX('%[0-9]GB%', UPPER(LTRIM(RTRIM([RAM])))) = 0 THEN 'FAIL'
            WHEN TRY_CAST(NULLIF(LTRIM(RTRIM([Credit Score])), '') AS int) IS NULL THEN 'FAIL'
            WHEN CASE WHEN UPPER(LTRIM(RTRIM([Channel]))) IN ('ONLINE','OFFLINE') THEN 1 ELSE 0 END = 0 THEN 'FAIL'
            WHEN CASE WHEN UPPER(LTRIM(RTRIM([Priority]))) IN ('LOW','MEDIUM','HIGH') THEN 1 ELSE 0 END = 0 THEN 'FAIL'
            WHEN TRY_CAST(REPLACE(NULLIF(LTRIM(RTRIM([Cost of Repairs])), ''), ',', '') AS decimal(18,2)) IS NULL THEN 'FAIL'
            WHEN TRY_CAST(REPLACE(NULLIF(LTRIM(RTRIM([Total Sales per Employee])), ''), ',', '') AS decimal(18,2)) IS NULL THEN 'FAIL'
            WHEN TRY_CAST(REPLACE(NULLIF(LTRIM(RTRIM([PC Market Price])), ''), ',', '') AS decimal(18,2)) IS NULL THEN 'FAIL'
            WHEN LEN(NULLIF(LTRIM(RTRIM([Storage Capacity])), '')) = 0 THEN 'FAIL'
            ELSE 'PASS'
        END,
        CASE
            WHEN LEN(NULLIF(LTRIM(RTRIM([Continent])), '')) = 0 THEN 'Continent is required'
            WHEN LEN(NULLIF(LTRIM(RTRIM([Country or State])), '')) = 0 THEN 'Country or State is required'
            WHEN LEN(NULLIF(LTRIM(RTRIM([Province or City])), '')) = 0 THEN 'Province or City is required'
            WHEN LEN(NULLIF(LTRIM(RTRIM([Shop Name])), '')) = 0 THEN 'Shop Name is required'
            WHEN TRY_CAST(NULLIF(LTRIM(RTRIM([Shop Age])), '') AS int) IS NULL THEN 'Shop Age must be integer'
            WHEN LEN(NULLIF(LTRIM(RTRIM([PC Make])), '')) = 0 THEN 'PC Make is required'
            WHEN LEN(NULLIF(LTRIM(RTRIM([PC Model])), '')) = 0 THEN 'PC Model is required'
            WHEN CASE WHEN UPPER(LTRIM(RTRIM([Storage Type]))) IN ('SSD','HDD') THEN 1 ELSE 0 END = 0 THEN 'Storage Type must be SSD or HDD'
            WHEN LEN(NULLIF(LTRIM(RTRIM([Customer Name])), '')) = 0 THEN 'Customer Name is required'
            WHEN LEN(NULLIF(LTRIM(RTRIM([Customer Surname])), '')) = 0 THEN 'Customer Surname is required'
            WHEN LEN(NULLIF(LTRIM(RTRIM([Customer Email Address])), '')) = 0 THEN 'Customer Email Address is required'
            WHEN CHARINDEX('@', NULLIF(LTRIM(RTRIM([Customer Email Address])), '')) = 0 THEN 'Customer Email Address is invalid'
            WHEN TRY_CAST(REPLACE(NULLIF(LTRIM(RTRIM([Cost Price])), ''), ',', '') AS decimal(18,2)) IS NULL THEN 'Cost Price must be numeric'
            WHEN TRY_CAST(REPLACE(NULLIF(LTRIM(RTRIM([Sale Price])), ''), ',', '') AS decimal(18,2)) IS NULL THEN 'Sale Price must be numeric'
            WHEN CASE WHEN UPPER(LTRIM(RTRIM([Payment Method]))) IN ('CASH','FINANCE','FINANCING','BANK TRANSFER','BANKTRANSFER') THEN 1 ELSE 0 END = 0 THEN 'Payment Method must be Cash, Finance or Bank Transfer'
            WHEN TRY_CAST(REPLACE(NULLIF(LTRIM(RTRIM([Discount Amount])), ''), ',', '') AS decimal(18,2)) IS NULL THEN 'Discount Amount must be numeric'
            WHEN TRY_CONVERT(date, NULLIF(LTRIM(RTRIM([Purchase Date])), '')) IS NULL THEN 'Purchase Date must be valid'
            WHEN UPPER(LTRIM(RTRIM([Ship Date]))) NOT IN ('N/A','NA','') AND TRY_CONVERT(date, NULLIF(LTRIM(RTRIM([Ship Date])), '')) IS NULL THEN 'Ship Date must be valid or N/A'
            WHEN TRY_CAST(REPLACE(NULLIF(LTRIM(RTRIM([Finance Amount])), ''), ',', '') AS decimal(18,2)) IS NULL THEN 'Finance Amount must be numeric'
            WHEN PATINDEX('%[0-9]GB%', UPPER(LTRIM(RTRIM([RAM])))) = 0 THEN 'RAM must include value and GB'
            WHEN TRY_CAST(NULLIF(LTRIM(RTRIM([Credit Score])), '') AS int) IS NULL THEN 'Credit Score must be integer'
            WHEN CASE WHEN UPPER(LTRIM(RTRIM([Channel]))) IN ('ONLINE','OFFLINE') THEN 1 ELSE 0 END = 0 THEN 'Channel must be Online or Offline'
            WHEN CASE WHEN UPPER(LTRIM(RTRIM([Priority]))) IN ('LOW','MEDIUM','HIGH') THEN 1 ELSE 0 END = 0 THEN 'Priority must be Low, Medium or High'
            WHEN TRY_CAST(REPLACE(NULLIF(LTRIM(RTRIM([Cost of Repairs])), ''), ',', '') AS decimal(18,2)) IS NULL THEN 'Cost of Repairs must be numeric'
            WHEN TRY_CAST(REPLACE(NULLIF(LTRIM(RTRIM([Total Sales per Employee])), ''), ',', '') AS decimal(18,2)) IS NULL THEN 'Total Sales per Employee must be numeric'
            WHEN TRY_CAST(REPLACE(NULLIF(LTRIM(RTRIM([PC Market Price])), ''), ',', '') AS decimal(18,2)) IS NULL THEN 'PC Market Price must be numeric'
            WHEN LEN(NULLIF(LTRIM(RTRIM([Storage Capacity])), '')) = 0 THEN 'Storage Capacity is required'
            ELSE NULL
        END
    FROM
        PC_Sales_Staging_dtw.dbo.Raw_PC_Data;

    IF OBJECT_ID('PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Cleaned', 'U') IS NOT NULL
    BEGIN
        DROP TABLE PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Cleaned;
    END;

    CREATE TABLE PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Cleaned(
        [Continent] [nvarchar](50) NOT NULL,
        [Country_or_State] [nvarchar](50) NOT NULL,
        [Province_or_City] [nvarchar](100) NOT NULL,
        [Shop_Name] [nvarchar](100) NOT NULL,
        [Shop_Age] int NOT NULL,
        [PC_Make] [nvarchar](50) NOT NULL,
        [PC_Model] [nvarchar](50) NOT NULL,
        [Storage_Type] [nvarchar](20) NOT NULL,
        [Customer_Name] [nvarchar](50) NOT NULL,
        [Customer_Surname] [nvarchar](50) NOT NULL,
        [Customer_Contact_Number] [nvarchar](50) NOT NULL,
        [Customer_Email_Address] [nvarchar](100) NOT NULL,
        [Sales_Person_Name] [nvarchar](50) NOT NULL,
        [Sales_Person_Department] [nvarchar](50) NOT NULL,
        [Cost_Price] decimal(18,2) NOT NULL,
        [Sale_Price] decimal(18,2) NOT NULL,
        [Payment_Method] [nvarchar](50) NOT NULL,
        [Discount_Amount] decimal(18,2) NOT NULL,
        [Purchase_Date] date NOT NULL,
        [Ship_Date] date NULL,
        [Finance_Amount] decimal(18,2) NOT NULL,
        [RAM] [nvarchar](20) NOT NULL,
        [Credit_Score] int NOT NULL,
        [Channel] [nvarchar](20) NOT NULL,
        [Priority] [nvarchar](20) NOT NULL,
        [Cost_of_Repairs] decimal(18,2) NOT NULL,
        [Total_Sales_per_Employee] decimal(18,2) NOT NULL,
        [PC_Market_Price] decimal(18,2) NOT NULL,
        [Storage_Capacity] [nvarchar](50) NOT NULL,
        [Load_Date] datetime DEFAULT GETDATE()
    );

    INSERT INTO PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Cleaned(
        [Continent],
        [Country_or_State],
        [Province_or_City],
        [Shop_Name],
        [Shop_Age],
        [PC_Make],
        [PC_Model],
        [Storage_Type],
        [Customer_Name],
        [Customer_Surname],
        [Customer_Contact_Number],
        [Customer_Email_Address],
        [Sales_Person_Name],
        [Sales_Person_Department],
        [Cost_Price],
        [Sale_Price],
        [Payment_Method],
        [Discount_Amount],
        [Purchase_Date],
        [Ship_Date],
        [Finance_Amount],
        [RAM],
        [Credit_Score],
        [Channel],
        [Priority],
        [Cost_of_Repairs],
        [Total_Sales_per_Employee],
        [PC_Market_Price],
        [Storage_Capacity]
    )
    SELECT
        [Continent],
        [Country_or_State],
        [Province_or_City],
        [Shop_Name],
        [Shop_Age],
        [PC_Make],
        [PC_Model],
        [Storage_Type],
        [Customer_Name],
        [Customer_Surname],
        [Customer_Contact_Number],
        [Customer_Email_Address],
        [Sales_Person_Name],
        [Sales_Person_Department],
        [Cost_Price],
        [Sale_Price],
        [Payment_Method],
        [Discount_Amount],
        [Purchase_Date],
        [Ship_Date],
        [Finance_Amount],
        [RAM],
        [Credit_Score],
        [Channel],
        [Priority],
        [Cost_of_Repairs],
        [Total_Sales_per_Employee],
        [PC_Market_Price],
        [Storage_Capacity]
    FROM
        PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Validation
    WHERE
        [Validation_Status] = 'PASS';

    IF OBJECT_ID('PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Errors', 'U') IS NOT NULL
    BEGIN
        DROP TABLE PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Errors;
    END;

    SELECT * INTO PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Errors
    FROM PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Validation
    WHERE [Validation_Status] = 'FAIL';

    SELECT
        COUNT(*) AS TotalRawRows,
        SUM(CASE WHEN [Validation_Status] = 'PASS' THEN 1 ELSE 0 END) AS ValidRows,
        SUM(CASE WHEN [Validation_Status] = 'FAIL' THEN 1 ELSE 0 END) AS InvalidRows
    FROM
        PC_Sales_Staging_dtw.dbo.Raw_PC_Data_Validation;
END;
