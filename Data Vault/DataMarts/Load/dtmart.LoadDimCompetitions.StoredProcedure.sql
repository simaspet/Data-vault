USE [model]
GO
/****** Object:  StoredProcedure [dtmart].[LoadDimCompetitions]    Script Date: 8/10/2023 5:16:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dtmart].[LoadDimCompetitions]
AS
SET NOCOUNT OFF
BEGIN 
    DECLARE @LogID INT;

    -- Log the start time
	INSERT INTO dbo.ProcedureLog (ProcedureName, StartTime)
	VALUES ('dtmart.LoadDimCompetitions', GETDATE());

    BEGIN TRY

TRUNCATE TABLE dtmart.DIM_Competitions

INSERT INTO dtmart.DIM_Competitions
(
	CompetitionsKey,
	GameID,
	CompetitionID,
	Season,
	Round,
	HomeClubID,
	AwayClubID,
	HomeClubManagerName,
	AwayClubManagerName,
	Stadium,
	Referee,
	Url,
	HomeClubName,
	AwayClubName,
	CompetitionType,
	CompetitionCode,
	Name,
	SubType,
	Type,
	CountryID,
	CountryName,
	DomesticLeagueCode,
	Confederation,
	UrlCompetition,
	DimLoadDate,
	SourceLoadDate
)

	SELECT CONVERT(VARCHAR(128), HASHBYTES('MD5', CAST(g.[GameID] AS VARCHAR(20))),2),
	g.GameID,
	g.CompetitionID,
	Season,
	Round,
	HomeClubID,
	AwayClubID,
	HomeClubManagerName,
	AwayClubManagerName,
	Stadium,
	Referee,
	g.Url,
	HomeClubName,
	AwayClubName,
	CompetitionType,
	CompetitionCode,
	Name,
	SubType,
	Type,
	CountryID,
	CountryName,
	DomesticLeagueCode,
	Confederation,
	c.Url,
	GETDATE(),
	g.SatLoadDate

	FROM SAT_Games as g
	inner join LINK_CompetitionsGames as link on g.HubGamesKey = link.HubGamesKey
	inner join SAT_Competitions as c on c.HubCompetitionsKey = link.HubCompetitionsKey

	WHERE g.SatEndDate IS NULL
	and c.SatEndDate IS NULL
	AND NOT EXISTS(
		SELECT 1
		FROM dtmart.DIM_Competitions as dim
		WHERE dim.CompetitionsKey = g.[HubGamesKey]
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
