USE [model]
GO
/****** Object:  StoredProcedure [dtmart].[LoadFactGames]    Script Date: 8/10/2023 5:16:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dtmart].[LoadFactGames]
AS
SET NOCOUNT OFF
BEGIN
    DECLARE @LogID INT;

    -- Log the start time
	INSERT INTO dbo.ProcedureLog (ProcedureName, StartTime)
	VALUES ('dtmart.LoadFactGames', GETDATE());

    BEGIN TRY

TRUNCATE TABLE dtmart.FACT_Games

INSERT INTO dtmart.FACT_Games
(
	GamesKey,
	ClubsGamesKey,
	CompetitionsKey,
	GameEventsKey,
	GameDateKey,
	TotalMarketValue,
	AverageAge,
	ForeignersNumber,
	NationalTeamPlayers,
	ForeignersPercentage,
	OwnGoals,
	OwnPosition,
	IsWin,
	HomeClubGoals,
	AwayClubGoals,
	HomeClubPosition,
	AwayClubPosition,
	Attendance,
	Aggregate,
	Minute,
	FactLoadDate,
	SourceLoadDate
)
	
SELECT
CONVERT(VARCHAR(128), HASHBYTES('MD5', 
    COALESCE(CAST(cg.[GameID] AS VARCHAR(20)), '') + 
    COALESCE(CAST(cg.[ClubID] AS VARCHAR(20)), '') +
    COALESCE(CAST(g.[GameID] AS VARCHAR(20)), '') +
    COALESCE(CAST(ge.[GameID] AS VARCHAR(20)), '') +
    COALESCE(CAST(ge.[PlayerID] AS VARCHAR(20)), '') +
    COALESCE(CONVERT(varchar(50), CONVERT(varchar(8), g.Date, 112)), '')
), 2),

	CONVERT(VARCHAR(128), HASHBYTES('MD5', 
    COALESCE(CAST(cg.[GameID] AS VARCHAR(20)), '') + 
    COALESCE(CAST(cg.[ClubID] AS VARCHAR(20)), '')
), 2),

	CONVERT(VARCHAR(128), HASHBYTES('MD5', CAST(g.[GameID] AS VARCHAR(20))), 2),

	CONVERT(VARCHAR(128), HASHBYTES('MD5', CAST(ge.[GameID] AS VARCHAR(20)) + CAST(ge.[PlayerID] AS VARCHAR(20))+CAST(ge.[MinuteID] as VARCHAR(20))), 2),

	CONVERT(VARCHAR(128), HASHBYTES('MD5', CONVERT(varchar(50),CONVERT(varchar(8),g.Date,112),112)), 2),
	TotalMarketValue,
	AverageAge,
	ForeignersNumber,
	NationalTeamPlayers,
	ForeignersPercentage,
	OwnGoals,
	OwnPosition,
	IsWin,
	HomeClubGoals,
	AwayClubGoals,
	HomeClubPosition,
	AwayClubPosition,
	Attendance,
	Aggregate,
	ge.MinuteID,
	GETDATE(),
	cg.SatLoadDate

	from SAT_ClubsGames as cg
	full join LINK_ClubsClubsGames as link1 on cg.[HubClubGamesKey] = link1.[HubClubGamesKey]
	full join SAT_Clubs as c on link1.HubClubsKey = c.HubClubsKey

	full join LINK_ClubsGamesGames as link2 on cg.HubClubGamesKey = link2.HubClubGamesKey
	full join SAT_Games as g on link2.HubGamesKey = g.HubGamesKey

	full join LINK_GamesGameEvents as link3 on g.HubGamesKey = link3.HubGamesKey
	full join SAT_GameEvents as ge on ge.HubGameEventsKey = link3.HubGameEventsKey

	full join LINK_CompetitionsGames as link4 on g.HubGamesKey = link4.HubGamesKey
	full join SAT_Competitions as cm on cm.HubCompetitionsKey = link4.HubCompetitionsKey

	WHERE cg.SatEndDate is null
	and c.SatEndDate is null
	and g.SatEndDate is null
	and cm.SatEndDate is null
	AND NOT EXISTS(
	SELECT 1
	FROM dtmart.FACT_Games as f
	WHERE f.GamesKey = CONVERT(VARCHAR(128), HASHBYTES('MD5', 
    COALESCE(CAST(cg.[GameID] AS VARCHAR(20)), '') + 
    COALESCE(CAST(cg.[ClubID] AS VARCHAR(20)), '') +
    COALESCE(CAST(g.[GameID] AS VARCHAR(20)), '') +
    COALESCE(CAST(ge.[GameID] AS VARCHAR(20)), '') +
    COALESCE(CAST(ge.[PlayerID] AS VARCHAR(20)), '') +
    COALESCE(CONVERT(varchar(50), CONVERT(varchar(8), g.Date, 112)), '')
), 2)
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
