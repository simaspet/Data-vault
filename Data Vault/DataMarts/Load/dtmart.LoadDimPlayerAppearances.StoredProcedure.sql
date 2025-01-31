USE [model]
GO
/****** Object:  StoredProcedure [dtmart].[LoadDimPlayerAppearances]    Script Date: 8/10/2023 5:16:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dtmart].[LoadDimPlayerAppearances]
AS
SET NOCOUNT OFF
BEGIN
    DECLARE @LogID INT;

    -- Log the start time
	INSERT INTO dbo.ProcedureLog (ProcedureName, StartTime)
	VALUES ('dtmart.LoadDimPlayerAppearances', GETDATE());

    BEGIN TRY

TRUNCATE TABLE dtmart.DIM_PlayerAppearances

INSERT INTO dtmart.DIM_PlayerAppearances
(
	AppearancesKey,
	AppearanceID,
	GameID,
	PlayerID,
	PlayerClubID,
	PlayerCurrentClubID,
	Date,
	CompetitionID,
	PlayerName,
	DimLoadDate,
	SourceLoadDate
)

	SELECT CONVERT(VARCHAR(128), HASHBYTES('MD5', CAST([AppearanceID] AS VARCHAR(20))),2),
	AppearanceID,
	GameID,
	PlayerID,
	PlayerClubID,
	PlayerCurrentClubID,
	Date,
	CompetitionID,
	PlayerName,
	GETDATE(),
	SatLoadDate

	FROM SAT_Appearances as ap
		WHERE NOT EXISTS(
		SELECT 1
		FROM dtmart.DIM_PlayerAppearances as dim
		WHERE dim.AppearancesKey = ap.[HubAppearancesKey]
		)
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
