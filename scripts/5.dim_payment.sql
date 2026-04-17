---Dim payment inserting primary key
DROP TABLE [PC_Sales_Staging_dtw].[dbo].[dim_payment] CREATE TABLE [PC_Sales_Staging_dtw].[dbo].[dim_payment](
    [Paymenty_ID] int identity (1, 1) primary key,
    [Payment_Method] [nvarchar](50) NOT NULL,
    [Load_date] DATETIME DEFAULT GETDATE()
) 
---Inserting data into table 
INSERT INTO
    [PC_Sales_Staging_dtw].[dbo].[dim_payment]([Payment_Method])
SELECT
    DISTINCT [Payment_Method]
FROM
    [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]
 ---checking if step was implemented
SELECT
    *
FROM
    [PC_Sales_Staging_dtw].[dbo].[dim_payment]