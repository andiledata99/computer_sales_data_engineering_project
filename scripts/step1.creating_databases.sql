--CREATE DATABASE [PC_Sales_Staging_dtw]
--CREATE DATABASE [PC_Sales_Production_dtw]
--
IF DB_ID('PC_Sales_Staging_dtw') IS NULL BEGIN CREATE DATABASE PC_Sales_Staging_dtw;

END
GO
    --
    IF DB_ID('PC_Sales_Production_dtw') IS NULL BEGIN CREATE DATABASE PC_Sales_Production_dtw;

END
GO