USE [model]
GO
/****** Object:  StoredProcedure [dtmart].[LoadDimClubsGames]    Script Date: 8/10/2023 5:16:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dtmart].[LoadDimClubsGames]
AS
SET NOCOUNT OFF
BEGIN 
    DECLARE @LogID INT;

    -- Log the start time
	INSERT INTO dbo.ProcedureLog (ProcedureName, StartTime)
	VALUES ('dtmart.LoadDimClubsGames', GETDATE());

    BEGIN TRY

TRUNCATE TABLE  dtmart.DIM_ClubsGames
INSERT INTO dtmart.DIM_ClubsGames
(
    ClubsGamesKey,
    ClubID,
    ClubCode,
    Name,
    DomesticCompetitionID,
    StadiumName,
    CoachName,
    LastSeason,
    Url,
    SquadSize,
    StadiumSeats,
    NetTransferRecord,
    GameID,
    OwnManagerName,
    OpponentID,
    OpponentManagerName,
    Hosting,
    HomeClubManagerName,
    AwayClubManagerName,
    Stadium,
    Referee,
    GameUrl,
    HomeClubName,
    AwayClubName,
    CompetitionType,
    DimLoadDate,
    SourceLoadDate
)

		SELECT CONVERT(VARCHAR(128), HASHBYTES('MD5', 
    COALESCE(CAST(cg.[GameID] AS VARCHAR(20)), '') + 
    COALESCE(CAST(cg.[ClubID] AS VARCHAR(20)), '')
), 2),
			cg.ClubID,
			ClubCode,
			Name,
			DomesticCompetitionID,
			StadiumName,
			CoachName,
			LastSeason,
			c.Url,
			SquadSize,
			StadiumSeats,
			NetTransferRecord,
			g.GameID,
			OwnManagerName,
			OpponentID,
			OpponentManagerName,
			Hosting,
			HomeClubManagerName,
			AwayClubManagerName,
			Stadium,
			Referee,
			g.Url,
			HomeClubName,
			AwayClubName,
			CompetitionType,
			GETDATE(),
			cg.SatLoadDate

			from SAT_ClubsGames as cg
			full join LINK_ClubsClubsGames as link1 on cg.[HubClubGamesKey] = link1.[HubClubGamesKey]
			full join SAT_Clubs as c on link1.HubClubsKey = c.HubClubsKey

			full join LINK_ClubsGamesGames as link2 on cg.HubClubGamesKey = link2.HubClubGamesKey
			full join SAT_Games as g on link2.HubGamesKey = g.HubGamesKey


			WHERE cg.SatEndDate IS NULL
			AND c.SatEndDate IS NULL
			AND g.SatEndDate IS NULL
			AND NOT EXISTS(
			SELECT 1
			FROM dtmart.DIM_ClubsGames as dim
			WHERE dim.ClubsGamesKey = cg.HubClubGamesKey
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
