USE [model]
GO
/****** Object:  StoredProcedure [dtmart].[LoadFactPlayers]    Script Date: 8/10/2023 5:16:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dtmart].[LoadFactPlayers]
AS
SET NOCOUNT OFF
BEGIN
    DECLARE @LogID INT;

    -- Log the start time
	INSERT INTO dbo.ProcedureLog (ProcedureName, StartTime)
	VALUES ('dtmart.LoadFactPlayers', GETDATE());

    BEGIN TRY

TRUNCATE TABLE dtmart.FACT_Players
INSERT INTO dtmart.FACT_Players
(
	PlayersKey,
	PlayerValuationsKey,
	PlayerAppearancesKey,
	ValuationDateKey,
	MarketValueInEur,
	HighestMarketValueInEur,
	MarketValueInEurYear,
	YellowCards,
	RedCards,
	Goals,
	Assists,
	MinutesPlayed,
	FactLoadDate,
	SourceLoadDate
)
	SELECT
		CONVERT(VARCHAR(128), HASHBYTES('MD5', 
    COALESCE(CAST(p.[PlayerID] AS VARCHAR(20)), '') +
    COALESCE(CAST(ap.[AppearanceID] AS VARCHAR(20)), '') +
    COALESCE(CONVERT(varchar(50), CONVERT(varchar(8), pv.[Date], 112)), '')
), 2)
,
		CONVERT(VARCHAR(128), HASHBYTES('MD5', 
    COALESCE(CAST(p.[PlayerID] AS VARCHAR(20)), '') +
    COALESCE(CAST(pv.[PlayerID] AS VARCHAR(20)), '')
), 2),
		CONVERT(VARCHAR(128), HASHBYTES('MD5', CAST(ap.[AppearanceID] AS VARCHAR(20))),2),

		CONVERT(VARCHAR(128), HASHBYTES('MD5', CONVERT(varchar(50),CONVERT(varchar(8),pv.[Date],112),112)), 2),
		p.MarketValueInEur,
		p.HighestMarketValueInEur,
		pv.MarketValueInEur,
		YellowCards,
		RedCards,
		Goals,
		Assists,
		MinutesPlayed,
		GETDATE(),
		pv.SatLoadDate

		from [dbo].[SAT_Players] as p
		full join LINK_PlayersPlayerValuations as link1 on p.HubPlayersKey = link1.HubPlayersKey
		full join SAT_PlayerValuations as pv on pv.HubPlayerValuationsKey = link1.HubPlayerValuationsKey
		full join LINK_PlayersAppearances as link2 on p.HubPlayersKey = link2.HubPlayersKey
		full join SAT_Appearances as ap on ap.[HubAppearancesKey] = link2.[HubAppearancesKey]

		WHERE p.SatEndDate is null
		and pv.SatEndDate is null
		and ap.SatEndDate is null
		and NOT EXISTS(
		SELECT 1
		FROM dtmart.FACT_Players as f
		WHERE f.PlayersKey = CONVERT(VARCHAR(128), HASHBYTES('MD5', 
    COALESCE(CAST(p.[PlayerID] AS VARCHAR(20)), '') +
    COALESCE(CAST(ap.[AppearanceID] AS VARCHAR(20)), '') +
    COALESCE(CONVERT(varchar(50), CONVERT(varchar(8), pv.[Date], 112)), '')
), 2)
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
