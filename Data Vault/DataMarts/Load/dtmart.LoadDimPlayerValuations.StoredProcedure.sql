USE [model]
GO
/****** Object:  StoredProcedure [dtmart].[LoadDimPlayerValuations]    Script Date: 8/10/2023 5:16:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dtmart].[LoadDimPlayerValuations]
AS
SET NOCOUNT OFF
BEGIN
    DECLARE @LogID INT;

    -- Log the start time
	INSERT INTO dbo.ProcedureLog (ProcedureName, StartTime)
	VALUES ('dtmart.LoadDimPlayerValuations', GETDATE());

    BEGIN TRY

TRUNCATE TABLE dtmart.DIM_PlayerValuations

INSERT INTO dtmart.DIM_PlayerValuations
(
	PlayerValuationKey,
	PlayerID,
	FirstName,
	LastName,
	Name,
	LastSeasonPlayer,
	CurrentClubID,
	PlayerCode,
	CountryOfBirth,
	CityOfBirth,
	CountryOfCitizenship,
	DateOfBirth,
	SubPosition,
	Position,
	Foot,
	HeightInCm,
	ContractExpirationDate,
	AgentName,
	ImageUrl,
	Url,
	CurrentClubDomesticCompetitionID,
	CurrentClubName,
	LastSeasonPV,
	Datetime,
	DateWeek,
	n,
	PlayerClubDomesticCompetitionID,
	DimLoadDate,
	SourceLoadDate
)
	SELECT CONVERT(VARCHAR(128), HASHBYTES('MD5', 
    COALESCE(CAST(p.[PlayerID] AS VARCHAR(20)), '') +
    COALESCE(CAST(pv.[PlayerID] AS VARCHAR(20)), '')
), 2),

	p.PlayerID,
	FirstName,
	LastName,
	Name,
	p.LastSeason,
	p.CurrentClubID,
	PlayerCode,
	CountryOfBirth,
	CityOfBirth,
	CountryOfCitizenship,
	DateOfBirth,
	SubPosition,
	Position,
	Foot,
	HeightInCm,
	ContractExpirationDate,
	AgentName,
	ImageUrl,
	Url,
	CurrentClubDomesticCompetitionID,
	CurrentClubName,
	pv.LastSeason,
	Datetime,
	DateWeek,
	n,
	PlayerClubDomesticCompetitionID,
	GETDATE(),
	pv.SatLoadDate

	from SAT_Players as p
	full join LINK_PlayersPlayerValuations as link on p.HubPlayersKey = link.HubPlayersKey
	full join SAT_PlayerValuations as pv on pv.HubPlayerValuationsKey = link.HubPlayerValuationsKey

		WHERE p.SatEndDate IS NULL
		AND pv.SatEndDate IS NULL
		AND NOT EXISTS(
		SELECT 1
		FROM dtmart.DIM_PlayerValuations as dim
		WHERE dim.PlayerValuationKey = pv.[HubPlayerValuationsKey]
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
