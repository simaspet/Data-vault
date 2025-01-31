USE [model]
GO
/****** Object:  StoredProcedure [dtmart].[LoadDimDate2]    Script Date: 8/10/2023 5:16:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dtmart].[LoadDimDate2]
AS
SET NOCOUNT OFF
BEGIN
    DECLARE @LogID INT;

    -- Log the start time
	INSERT INTO dbo.ProcedureLog (ProcedureName, StartTime)
	VALUES ('dtmart.LoadDimDate2', GETDATE());

    BEGIN TRY


TRUNCATE TABLE dtmart.DIM_Date;

INSERT INTO dtmart.DIM_Date
(
    DateKey,
    Date,
    Year,
    Month,
    Day,
    Time,
    GameDateKey,
    ValuationDateKey,
    DimLoadDate,
    SourceLoadDate
)
SELECT
    DISTINCT(CONVERT(VARCHAR(128), HASHBYTES('MD5', COALESCE(CONVERT(varchar(8), Date, 112), '')), 2)) AS DateKey,
    Date,
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    DAY(Date) AS Day,
    CAST('00:00:00' AS TIME) AS Time,
    Date AS GameDateKey,
    NULL AS ValuationDateKey,
    GETDATE() AS DimLoadDate,
    SatLoadDate AS SourceLoadDate
FROM
    SAT_Games
WHERE
    NOT EXISTS (
        SELECT 1
        FROM dtmart.DIM_Date dim
        WHERE dim.DateKey = CONVERT(VARCHAR(128), HASHBYTES('MD5', COALESCE(CAST(Date AS VARCHAR(20)), '')), 2)
    )
UNION ALL
SELECT
    DISTINCT(CONVERT(VARCHAR(128), HASHBYTES('MD5', COALESCE(CONVERT(varchar(8), Date, 112), '')), 2)) AS DateKey,
    Date,
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    DAY(Date) AS Day,
    CAST('00:00:00' AS TIME) AS Time,
    NULL AS GameDateKey,
    Date AS ValuationDateKey,
    GETDATE() AS DimLoadDate,
    SatLoadDate AS SourceLoadDate
FROM
    SAT_PlayerValuations
WHERE
    NOT EXISTS (
        SELECT 1
        FROM dtmart.DIM_Date dim
        WHERE dim.DateKey = CONVERT(VARCHAR(128), HASHBYTES('MD5', COALESCE(CAST(Date AS VARCHAR(20)), '')), 2)
    );
	END TRY
    BEGIN CATCH
        -- Log error information
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();

        UPDATE dbo.ProcedureLog
        SET EndTime = GETDATE(),
            ErrorMessage = @ErrorMessage
        WHERE LogID = @LogID;

        -- Rethrow the error
        THROW;
    END CATCH;

    -- Log successful execution
    UPDATE dbo.ProcedureLog
    SET EndTime = GETDATE()
    WHERE LogID = @LogID;

end;
GO
