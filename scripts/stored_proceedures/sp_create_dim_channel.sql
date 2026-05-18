

/*
=======================================================
Stored Procedure: sp_create_dim_channel
Description: Creates and populates dim_channel dimension
Purpose: Store sales channel information
Author: Data Engineer Andile Dube
Date: 2026-05-13
=======================================================
*/

CREATE OR ALTER PROCEDURE dbo.sp_create_dim_channel
AS
BEGIN
    SET NOCOUNT ON;

    -- Dim channel dimension table creation
    IF OBJECT_ID('PC_Sales_Staging_dtw.dbo.dim_channel', 'U') IS NULL
    BEGIN
        CREATE TABLE [PC_Sales_Staging_dtw].[dbo].[dim_channel](
            [Channel_ID] int IDENTITY(1,1) PRIMARY KEY,
            [Channel] [nvarchar](50) NOT NULL,
            [Load_date] DATETIME DEFAULT GETDATE()
        );
    END;

    -- Insert distinct channel records from raw data, avoid duplicates
    INSERT INTO [PC_Sales_Staging_dtw].[dbo].[dim_channel]([Channel])
    SELECT DISTINCT rd.[Channel]
    FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data] rd
    WHERE NOT EXISTS (
        SELECT 1 FROM [PC_Sales_Staging_dtw].[dbo].[dim_channel] d
        WHERE d.Channel = rd.Channel
    );

    -- Verification Query: Display loaded channel dimension records
    SELECT * FROM [PC_Sales_Staging_dtw].[dbo].[dim_channel];
END;
GO