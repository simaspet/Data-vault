USE [model]
GO
/****** Object:  StoredProcedure [dbo].[LoadLink]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LoadLink]
(
    @LinkTableName NVARCHAR(255)
)
AS
SET NOCOUNT OFF

BEGIN

DECLARE @OnePK NVARCHAR(128);
DECLARE @TwoPK NVARCHAR(128);
DECLARE @ThreePK NVARCHAR(128);
DECLARE @LinkStageTableName NVARCHAR(255);
DECLARE @StageOnePK NVARCHAR(128);
DECLARE @StageTwoPK NVARCHAR(128);
DECLARE @StageThreePK NVARCHAR(128);
DECLARE @MatchExpression NVARCHAR(255);
DECLARE @ColumnList NVARCHAR(MAX);
DECLARE @PrimaryKeyList NVARCHAR(128);
DECLARE @StagePrimaryKeyList NVARCHAR(128);
DECLARE @TempStageOnePK NVARCHAR(128);
DECLARE @TempStageTwoPK NVARCHAR(128);
DECLARE @AllPK NVARCHAR(128);
DECLARE @LinkPK NVARCHAR(128);
DECLARE @LinkStageTableName1 NVARCHAR(128);
DECLARE @LinkStageTableName2 NVARCHAR(128);
DECLARE @PrimaryKeyFirstStageTable NVARCHAR(128);
DECLARE @PrimaryKeySecondStageTable NVARCHAR(128);
DECLARE @FirstPKConcat NVARCHAR(MAX);
DECLARE @SecondPKConcat NVARCHAR(MAX);
DECLARE @FirstPKConcat2 NVARCHAR(MAX);
DECLARE @SecondPKConcat2 NVARCHAR(MAX);


SET @MatchExpression = '%[^a-z0-9]%';
SET @ColumnList = '';
SET @PrimaryKeyList = '';
SET @StagePrimaryKeyList = '';


--DECLARE @LinkTableName NVARCHAR(255);
--SET @LinkTableName = 'LINK_CompetitionsGames';

    -- Column listai
    SELECT @ColumnList = @ColumnList + QUOTENAME(name) + ','
    FROM sys.columns
    WHERE object_id = OBJECT_ID(@LinkTableName);
    SET @ColumnList = LEFT(@ColumnList, LEN(@ColumnList) - 1);
	print @ColumnList;

DECLARE @ResultTable TABLE (
    Row INT,
    Name NVARCHAR(255)
);
INSERT INTO @ResultTable (Row, Name)
SELECT
    ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS Row,
    name
FROM sys.columns
WHERE object_id = OBJECT_ID(@LinkTableName)
  AND name NOT LIKE ('%Key%')
  AND name NOT LIKE ('%LoadDate%')
  AND name NOT LIKE ('%RecordSource%');


DECLARE @ResultTableStage TABLE (
    Row INT,
    Name NVARCHAR(255)
);
INSERT INTO @ResultTableStage (Row, Name)
SELECT
    ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS Row,
    name
FROM sys.columns
WHERE object_id = OBJECT_ID(@LinkTableName)


	    -- pirmas PK is Hub
    SELECT @OnePK = name
    FROM @ResultTable
    WHERE Row = 1
	print @OnePK;

	    -- Antras PK is Hub
    SELECT @TwoPK = name
    FROM @ResultTable
    WHERE Row = 2
	print @TwoPK;

		 -- Trecias PK is Hub
    SELECT @ThreePK = name
    FROM @ResultTable
    WHERE Row = 3
	print @ThreePK;


  	-- Pakeisti linko 1pk i stage 1pk
	SELECT @StageOnePK = REPLACE(LOWER(Name), 'ID', '_id')
	FROM @ResultTable
	WHERE Row =1;
	print @StageOnePK;

	-- Pakeisti linko 2pk i stage 2pk
	SELECT @StageTwoPK = REPLACE(LOWER(Name), 'ID', '_id')
	FROM @ResultTable
	WHERE Row =2;
	print @StageTwoPK;


SELECT @LinkStageTableName1 = 
REPLACE(a.name,('HUB_'),('Stage.'))
FROM sys.tables a
JOIN sys.columns b ON a.object_id = b.object_id
JOIN @ResultTableStage as res on res.Name = b.name
WHERE res.Row = 2 and a.name like ('HUB_%')

print @LinkStageTableName1

SELECT @LinkStageTableName2 = 
REPLACE(a.name,('HUB_'),('Stage.'))
FROM sys.tables a
JOIN sys.columns b ON a.object_id = b.object_id
JOIN @ResultTableStage as res on res.Name = b.name
WHERE res.Row = 3 and a.name like ('HUB_%')

print @LinkStageTableName2


SELECT @FirstPKConcat = 's.' + @StageOnePK


IF @StageTwoPK LIKE ('%+%')
BEGIN
	SET @SecondPKConcat = 'CONCAT(p.' + replace(@StageTwoPK,'+',', p.')+')';
END;
ELSE
BEGIN
	SET @SecondPKConcat = 'p.' + replace(@StageTwoPK,'+',', p.');
END;

print @FirstPKConcat

print @SecondPKConcat

SELECT @FirstPKConcat2 = 'CONVERT(NVARCHAR(128), UPPER(s.'+ @StageOnePK + ')';

IF @StageTwoPK LIKE ('%+%')
BEGIN
	SET @SecondPKConcat2 = 'CONCAT(CONVERT(NVARCHAR(128), UPPER(p.' + replace(@StageTwoPK, '+', ')), CONVERT(NVARCHAR(128), UPPER(p.') + ')';
END;
ELSE
BEGIN
	SET @SecondPKConcat2 = 'CONVERT(NVARCHAR(128), UPPER(p.' + replace(@StageTwoPK, '+', ')), CONVERT(NVARCHAR(128), UPPER(p.');
END;

DECLARE @sql NVARCHAR(MAX);

SET @sql = N'
    TRUNCATE TABLE ' + @LinkTableName + '
    INSERT INTO ' + @LinkTableName + ' (' + @ColumnList + ')
    SELECT 
        CONVERT(NVARCHAR(128), HASHBYTES(''MD5'', CONCAT(' + @FirstPKConcat2 + '), ' + @SecondPKConcat2 + ')))), 2),
        CONVERT(NVARCHAR(128), HASHBYTES(''MD5'', ' + @FirstPKConcat2 + ')), 2),
        CONVERT(NVARCHAR(128), HASHBYTES(''MD5'', ' + @SecondPKConcat2 + '))), 2),
        CONVERT(NVARCHAR(128), HASHBYTES(''MD5'', CONCAT(''' + @LinkStageTableName1 + ''',''' + @LinkStageTableName2 + ''')), 2),
        GETDATE(),
        ' + @FirstPKConcat + ',
        ' + @SecondPKConcat + '
    FROM ' + @LinkStageTableName1 + ' AS s
    JOIN ' + @LinkStageTableName2 + ' AS p
    ON s.' + @StageOnePK + ' = p.' + @StageOnePK;

  	PRINT @sql  --Error handling 
	EXEC sp_executesql @sql

end;
GO
