/*
=======================================================
Stored Procedure: sp_create_dim_payment
Description: Creates and populates dim_payment dimension
Purpose: Store payment method information
Author: Data Engineer Andile Dube
Date: 2026-05-13
=======================================================
*/

CREATE OR ALTER PROCEDURE dbo.sp_create_dim_payment
AS
BEGIN
    SET NOCOUNT ON;

    -- Dim payment dimension table creation
    IF OBJECT_ID('PC_Sales_Staging_dtw.dbo.dim_payment', 'U') IS NULL
    BEGIN
        CREATE TABLE [PC_Sales_Staging_dtw].[dbo].[dim_payment](
            [Paymenty_ID] int IDENTITY(1,1) PRIMARY KEY,
            [Payment_Method] [nvarchar](50) NOT NULL,
            [Load_date] DATETIME DEFAULT GETDATE()
        );
    END;

    -- Insert distinct payment method records from raw data, avoid duplicates
    INSERT INTO [PC_Sales_Staging_dtw].[dbo].[dim_payment]([Payment_Method])
    SELECT DISTINCT rd.[Payment_Method]
    FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data] rd
    WHERE NOT EXISTS (
        SELECT 1 FROM [PC_Sales_Staging_dtw].[dbo].[dim_payment] d
        WHERE d.Payment_Method = rd.Payment_Method
    );

    -- Verification Query: Display loaded payment dimension records
    SELECT * FROM [PC_Sales_Staging_dtw].[dbo].[dim_payment];
END;
GO