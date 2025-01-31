USE [model]
GO
/****** Object:  StoredProcedure [dtmart].[LoadDimDate]    Script Date: 8/10/2023 5:16:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dtmart].[LoadDimDate]
AS
SET NOCOUNT OFF
BEGIN
    DECLARE @LogID INT;

    -- Log the start time
	INSERT INTO dbo.ProcedureLog (ProcedureName, StartTime)
	VALUES ('dtmart.LoadDimDate', GETDATE());

    BEGIN TRY
TRUNCATE TABLE dtmart.DIM_Date

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
    DISTINCT(CONVERT(VARCHAR(128), HASHBYTES('MD5', COALESCE(CONVERT(varchar(8), g.[Date], 112), '') + COALESCE(CONVERT(varchar(8), pv.[Date], 112), '')), 2)) AS DateKey,
    COALESCE(g.[Date], pv.[Date]) AS Date,
    COALESCE(YEAR(g.[Date]), YEAR(pv.[Date])) AS Year,
    COALESCE(MONTH(g.[Date]), MONTH(pv.[Date])) AS Month,
    COALESCE(DAY(g.[Date]), DAY(pv.[Date])) AS Day,
    CAST('00:00:00' AS TIME) AS Time, -- Set a default time value '00:00:00'
    g.[Date] AS GameDateKey,
    pv.[Date] AS ValuationDateKey,
    GETDATE() AS DimLoadDate,
    COALESCE(g.SatLoadDate, pv.SatLoadDate) AS SourceLoadDate
FROM
    SAT_Games g
FULL JOIN SAT_PlayerValuations pv ON g.[Date] = pv.[Date]
WHERE
    NOT EXISTS (
        SELECT 1
        FROM dtmart.DIM_Date dim
        WHERE dim.DateKey = CONVERT(VARCHAR(128), HASHBYTES('MD5', COALESCE(CAST(g.[Date] AS VARCHAR(20)), '') + COALESCE(CAST(pv.[Date] AS VARCHAR(20)), '')), 2)
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
