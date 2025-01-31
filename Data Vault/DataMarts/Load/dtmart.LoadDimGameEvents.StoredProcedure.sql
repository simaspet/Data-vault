USE [model]
GO
/****** Object:  StoredProcedure [dtmart].[LoadDimGameEvents]    Script Date: 8/10/2023 5:16:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dtmart].[LoadDimGameEvents]
AS
SET NOCOUNT OFF
BEGIN 
    DECLARE @LogID INT;

    -- Log the start time
	INSERT INTO dbo.ProcedureLog (ProcedureName, StartTime)
	VALUES ('dtmart.LoadDimGameEvents', GETDATE());

    BEGIN TRY

TRUNCATE TABLE dtmart.DIM_GameEvents

INSERT INTO dtmart.DIM_GameEvents
(
	GameEventsKey,
	GameID,
	Type,
	ClubID,
	PlayerID,
	Description,
	PlayerInID,
	DimLoadDate,
	SourceLoadDate

)
	SELECT CONVERT(VARCHAR(128), HASHBYTES('MD5', CAST([GameID] AS VARCHAR(20)) + CAST([PlayerID] AS VARCHAR(20))+CAST([MinuteID] as VARCHAR(20))), 2),
	GameID,
	Type,
	ClubID,
	PlayerID,
	Description,
	PlayerInID,
	GETDATE(),
	SatLoadDate

	FROM SAT_GameEvents as ge
		WHERE NOT EXISTS(
		SELECT 1
		FROM dtmart.DIM_GameEvents as dim
		WHERE dim.GameEventsKey = ge.[HubGameEventsKey]
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
