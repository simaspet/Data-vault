USE [model]
GO
/****** Object:  StoredProcedure [dbo].[LoadHub]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LoadHub]
(
    @HubTableName NVARCHAR(255)
)
AS
SET NOCOUNT OFF

BEGIN


	--DECLARE @HubTableName NVARCHAR(255);
	--SET @HubTableName = 'HUB_Minute';
    DECLARE @OnePK NVARCHAR(128);
    DECLARE @TwoPK NVARCHAR(128);
	DECLARE @ThreePK NVARCHAR(128);
    DECLARE @HubStageTableName NVARCHAR(255);
    DECLARE @StageOnePK NVARCHAR(128);
    DECLARE @StageTwoPK NVARCHAR(128);
	DECLARE @StageThreePK NVARCHAR(128);
    DECLARE @MatchExpression NVARCHAR(255);
    DECLARE @ColumnList NVARCHAR(MAX);
    DECLARE @PrimaryKeyList NVARCHAR(128);
    DECLARE @StagePrimaryKeyList NVARCHAR(128);
	DECLARE @TempStageOnePK NVARCHAR(128);
	DECLARE @TempStageTwoPK NVARCHAR(128);
	DECLARE @AllPK NVARCHAR(MAX);


    SET @MatchExpression = '%[^a-z0-9]%';
    SET @ColumnList = '';
    SET @PrimaryKeyList = '';
    SET @StagePrimaryKeyList = '';

    -- Column listai
    SELECT @ColumnList = @ColumnList + QUOTENAME(name) + ','
    FROM sys.columns
    WHERE object_id = OBJECT_ID(@HubTableName);
    SET @ColumnList = LEFT(@ColumnList, LEN(@ColumnList) - 1);
	--print @ColumnList


    -- Primary key listas
    SELECT @PrimaryKeyList = @PrimaryKeyList + QUOTENAME(name) + ','
    FROM sys.columns
    WHERE object_id = OBJECT_ID(@HubTableName) AND column_id > 3;
    SET @PrimaryKeyList = LEFT(@PrimaryKeyList, LEN(@PrimaryKeyList) - 1);
	--print @PrimaryKeyList


    -- pirmas PK is Hub
    SELECT TOP 1 @OnePK = name
    FROM sys.columns
    WHERE object_id = OBJECT_ID(@HubTableName) AND column_id = 4;
	--print @OnePK


    -- Antras PK is Hub
    SELECT TOP 1 @TwoPK = name
    FROM sys.columns
    WHERE object_id = OBJECT_ID(@HubTableName) AND column_id = 5;
	--print @TwoPK

    -- Trecias PK is Hub
    SELECT TOP 1 @ThreePK = name
    FROM sys.columns
    WHERE object_id = OBJECT_ID(@HubTableName) AND column_id = 6;
	--print @ThreePK


    -- Stage lentele
    SET @HubStageTableName = REPLACE(@HubTableName, 'HUB_', 'stage.');
	--print @HubStageTableName


	-- Pakeisti hubo 1pk i stage 1pk

	SELECT TOP 1 @StageOnePK = name
	FROM sys.columns
	WHERE object_id = OBJECT_ID(@HubStageTableName) AND name LIKE replace(lower(@OnePK),'ID','_id');
	--print @StageOnePK


	-- Pakeisti hubo 2pk i stage 2pk

	SELECT TOP 1 @StageTwoPK = name
	FROM sys.columns
	WHERE object_id = OBJECT_ID(@HubStageTableName) AND name LIKE replace(lower(@TwoPK),'ID','_id');
	--print @StageTwoPK

	-- Pakeisti hubo 3pk i stage 3pk

	SELECT TOP 1 @StageThreePK = name
	FROM sys.columns
	WHERE object_id = OBJECT_ID(@HubStageTableName) AND name LIKE replace(lower(@ThreePK),'ID','_id');
	--print @StageThreePK

    -- Stage PK listas
	IF LEN(@ThreePK) > 0
	BEGIN
		SELECT @StagePrimaryKeyList = CONCAT(@StageOnePK, ',', @StageTwoPK, ',', @StageThreePK)
		FROM sys.columns
		WHERE object_id = OBJECT_ID(@HubStageTableName);
	END
	ELSE
	BEGIN
		IF LEN(@TwoPK) > 0
		BEGIN
			SELECT @StagePrimaryKeyList = CONCAT(@StageOnePK, ',', @StageTwoPK)
			FROM sys.columns
			WHERE object_id = OBJECT_ID(@HubStageTableName);
		END
		ELSE
		BEGIN
			SELECT @StagePrimaryKeyList = @StageOnePK
			FROM sys.columns
			WHERE object_id = OBJECT_ID(@HubStageTableName);
		END;
	END;

--PRINT @StagePrimaryKeyList;


    -- Dinaminis sql


    DECLARE @sql NVARCHAR(MAX);

IF LEN(@ThreePK) > 0
BEGIN
    SET @AllPK = 'CONCAT(CONVERT(NVARCHAR(128), UPPER(s.' + @StageOnePK + ')), CONVERT(NVARCHAR(128), UPPER(s.' + @StageTwoPK + ')), CONVERT(NVARCHAR(128), UPPER(s.' + @StageThreePK+')';
END
ELSE IF LEN(@TwoPK) > 0
BEGIN
    SET @AllPK = 'CONCAT(CONVERT(NVARCHAR(128), UPPER(s.' + @StageOnePK + ')), CONVERT(NVARCHAR(128), UPPER(s.' + @StageTwoPK + ')';
END
ELSE
BEGIN
    SET @AllPK = 'CONVERT(NVARCHAR(128), UPPER(s.' + @StageOnePK;
END;

--PRINT @AllPK;




    SET @sql = N'
    INSERT INTO ' + @HubTableName + ' (' + @ColumnList + ') 
    SELECT 
        CONVERT(NVARCHAR(128), HASHBYTES(''MD5'',' + @AllPK + '))), 2),
        CONVERT(NVARCHAR(128), HASHBYTES(''MD5'', ''' + @HubStageTableName + '''), 2),
        GETDATE(),
        ' + @StagePrimaryKeyList + '
    FROM ' + @HubStageTableName + ' AS s
    WHERE NOT EXISTS (
        SELECT 1 
        FROM ' + @HubTableName + ' AS Hub 
        WHERE Hub.' + @OnePK + ' = s.' + @StageOnePK;

    -- kai yra 2PK
    IF @TwoPK IS NOT NULL
    BEGIN
        SET @sql += ' AND Hub.' + @TwoPK + ' = s.' + @StageTwoPK;
    END
	IF @ThreePK IS NOT NULL
    BEGIN
        SET @sql += ' AND Hub.' + @ThreePK + ' = s.' + @StageThreePK;
    END

    SET @sql += ')';

    -- Printas
    --PRINT(@sql);


    EXEC sp_executesql @sql;

END;
GO
