/*
=======================================================
Stored Procedure: sp_create_dim_pc_spec
Description: Creates and populates dim_pc_spec dimension
Purpose: Store PC specification information
Author: Data Engineer Andile Dube
Date: 2026-05-13
=======================================================
*/

CREATE OR ALTER PROCEDURE dbo.sp_create_dim_pc_spec
AS
BEGIN
    SET NOCOUNT ON;

    -- Dim pc spec dimension table creation
    IF OBJECT_ID('PC_Sales_Staging_dtw.dbo.dim_pc_spec', 'U') IS NULL
    BEGIN
        CREATE TABLE [PC_Sales_Staging_dtw].[dbo].[dim_pc_spec](
            [PC_make_ID] int IDENTITY(1,1) PRIMARY KEY,
            [PC_Make] [nvarchar](50) NOT NULL,
            [PC_Model] [nvarchar](50) NOT NULL,
            [Storage_Type] [nvarchar](50) NOT NULL,
            [RAM] [nvarchar](50) NOT NULL,
            [Storage_Capacity] [nvarchar](50) NOT NULL,
            [Load_date] DATETIME DEFAULT GETDATE()
        );
    END;

    -- Insert distinct PC specification records from raw data, avoid duplicates
    INSERT INTO [PC_Sales_Staging_dtw].[dbo].[dim_pc_spec](
        [PC_Make],
        [PC_Model],
        [Storage_Type],
        [RAM],
        [Storage_Capacity]
    )
    SELECT DISTINCT
        rd.[PC_Make],
        rd.[PC_Model],
        rd.[Storage_Type],
        rd.[RAM],
        rd.[Storage_Capacity]
    FROM [PC_Sales_Staging_dtw].[dbo].[Raw_PC_Data] rd
    WHERE NOT EXISTS (
        SELECT 1 FROM [PC_Sales_Staging_dtw].[dbo].[dim_pc_spec] d
        WHERE d.PC_Make = rd.PC_Make
          AND d.PC_Model = rd.PC_Model
          AND d.Storage_Type = rd.Storage_Type
          AND d.RAM = rd.RAM
          AND d.Storage_Capacity = rd.Storage_Capacity
    );

    -- Verification Query: Display loaded PC specification dimension records
    SELECT * FROM [PC_Sales_Staging_dtw].[dbo].[dim_pc_spec];
END;
GO