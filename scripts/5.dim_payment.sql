/*
=======================================================
Script: 5.dim_payment.sql
Description: Creates and populates dim_payment dimension table
Purpose: Store payment method information
Author: Data Engineering Team
Date: 2026-05-13
=======================================================
*/

CREATE TABLE IF NOT EXISTS [PC_Sales_Staging_dtw].[dbo].[dim_payment](
    [Paymenty_ID] int identity (1, 1) primary key,
    [Payment_Method] [nvarchar](50) NOT NULL,
    [Load_date] DATETIME DEFAULT GETDATE()
)

-- Insert distinct payment method records from raw data
INSERT INTO
    [PC_Sales_Staging_dtw].[dbo].[dim_payment]([Payment_Method])
SELECT
    DISTINCT [Payment_Method]
FROM
    [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data]

-- Verification Query: Display loaded payment dimension records
SELECT
    *
FROM
    [PC_Sales_Staging_dtw].[dbo].[dim_payment]