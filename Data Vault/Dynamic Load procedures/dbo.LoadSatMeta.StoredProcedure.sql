USE [model]
GO
/****** Object:  StoredProcedure [dbo].[LoadSatMeta]    Script Date: 8/8/2023 3:15:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[LoadSatMeta]
(
    @SatTableName NVARCHAR(255)
)
AS
SET NOCOUNT OFF

BEGIN

--DECLARE @SatTableName NVARCHAR(255);
--SET @SatTableName = 'SAT_PlayerValuations';

DECLARE @ColumnList NVARCHAR(MAX);
DECLARE @SatStageTableName NVARCHAR(255);
DECLARE @StagePK VARCHAR(255);
DECLARE @StageColumnList NVARCHAR(MAX);
DECLARE @listas NVARCHAR(MAX);
DECLARE @SatPK VARCHAR(255);
DECLARE @ModifiedColumns NVARCHAR(MAX);
DECLARE @Delimiter NVARCHAR(10) = ',';
DECLARE @TempColumnList TABLE (ColumnName NVARCHAR(200));
DECLARE @TempStageColumns TABLE (StageColumnName NVARCHAR(200));
DECLARE @StageModifiedColumns NVARCHAR(MAX);
DECLARE @StageDelimiter NVARCHAR(10) = ',';
DECLARE @TableNameForStage NVARCHAR(128);
DECLARE @PrimaryKeyListUPPER NVARCHAR(128);
DECLARE @ColumnListOther NVARCHAR(MAX);
DECLARE @sql  NVARCHAR(MAX);

SET @listas = '';
SET @ColumnList = '';
SET @StageColumnList = '';

SELECT
    @listas = @listas +
    CASE
        WHEN st.name IN ('varchar', 'nvarchar') THEN
            (sc.name) + ' ' + st.name + '(' + ISNULL(CONVERT(NVARCHAR(255), sc.max_length), '') + '),'
        ELSE
            (sc.name) +' '+ (st.name) +', '
    END
FROM sys.columns AS sc
INNER JOIN sys.types AS st ON sc.user_type_id = st.user_type_id
WHERE OBJECT_ID = OBJECT_ID(@SatTableName);
SET @listas = LEFT(@listas, LEN(@listas) - 1);

--------Stage lentele

SET @TableNameForStage = (SELECT StageTable FROM [stage].[MetaDataTable] WHERE SatTable = @SatTableName);
--print @TableNameForStage;


    -- Column listai
    SELECT @ColumnList = @ColumnList + QUOTENAME(name) + ','
    FROM sys.columns
    WHERE object_id = OBJECT_ID(@SatTableName);
    SET @ColumnList = LEFT(@ColumnList, LEN(@ColumnList) - 1);
--print @ColumnList

	--- Column templist

	INSERT INTO @TempColumnList (ColumnName)
	SELECT TRIM(VALUE) AS ColumnName
	FROM STRING_SPLIT(@ColumnList, @Delimiter);
	UPDATE @TempColumnList
	SET ColumnName = '#'+ @SatTableName + '.' + ColumnName;
	SELECT @ModifiedColumns = STRING_AGG(ColumnName, @Delimiter)
	FROM @TempColumnList;

	--print @ModifiedColumns;

	---PrimaryKeyListUpper

SELECT @PrimaryKeyListUPPER = STRING_AGG(
    'UPPER(' + ColumnName + ')',
    '+'
) WITHIN GROUP (ORDER BY SortOrder)
FROM (
    SELECT DISTINCT StageColumn1 AS ColumnName, 1 AS SortOrder
    FROM sys.columns a
    JOIN sys.tables b ON a.object_id = b.object_id
    JOIN stage.MetaDataTable AS mt ON b.name = @SatTableName
    WHERE SatTable = @SatTableName AND LEN(StageColumn1) > 0
        
    UNION

    SELECT DISTINCT StageColumn2 AS ColumnName, 2 AS SortOrder
    FROM sys.columns a
    JOIN sys.tables b ON a.object_id = b.object_id
    JOIN stage.MetaDataTable AS mt ON b.name = @SatTableName
    WHERE SatTable = @SatTableName AND LEN(StageColumn2) > 0
        
    UNION

    SELECT DISTINCT StageColumn3 AS ColumnName, 3 AS SortOrder
    FROM sys.columns a
    JOIN sys.tables b ON a.object_id = b.object_id
    JOIN stage.MetaDataTable AS mt ON b.name = @SatTableName
    WHERE SatTable = @SatTableName AND LEN(StageColumn3) > 0
) AS AggregatedColumns;

--PRINT @PrimaryKeyListUPPER;

--- stage column listas

	SELECT @StageColumnList = @StageColumnList + name + ','
	from sys.columns
	WHERE object_id = OBJECT_ID('stage.'+@TableNameForStage)
	SET @StageColumnList = LEFT(@StageColumnList, LEN(@StageColumnList) - 1);
	--print @StageColumnList



	--- stage column templist

	INSERT INTO @TempStageColumns (StageColumnName)
	SELECT TRIM(VALUE) AS StageColumnName
	FROM STRING_SPLIT(@StageColumnList, @StageDelimiter);

	UPDATE @TempStageColumns
	SET StageColumnName = 'UPPER(' + StageColumnName + ')';

	SELECT @StageModifiedColumns = STRING_AGG(StageColumnName, @StageDelimiter)
	FROM @TempStageColumns;

	--print @StageModifiedColumns;

	select top 1 @SatPK = name
	from sys.columns
	WHERE object_id = OBJECT_ID(@SatTableName);
	--print(@SatPK);


SET @sql = N'
CREATE TABLE #' + @SatTableName +
'(' + @listas + '); ' +

'INSERT INTO #' + @SatTableName + ' (' + @ColumnList + ') 
SELECT
	  CONVERT(NVARCHAR(128), HASHBYTES(''MD5'', CONVERT(varchar(128),' + @PrimaryKeyListUPPER + ')), 2),
	  GETDATE(),
	  NULL,
	  CONVERT(NVARCHAR(128), HASHBYTES(''MD5'', ''stage.' + @TableNameForStage + '''), 2),
	  CONVERT(NVARCHAR(128), HASHBYTES(''MD5'', CONCAT(' + @StageModifiedColumns + ')), 2),'
	  + @StageColumnList + '
FROM stage.' + @TableNameForStage + ';' +

'UPDATE ' + @SatTableName + '
SET ' + @SatTableName + '.SatEndDate = GETDATE()
FROM #' + @SatTableName + ' 
WHERE '+ @SatTableName + '.' + @SatPK + ' = #' + @SatTableName + '.' + @SatPK + '
	AND '+ @SatTableName + '.SatEndDate IS NULL' +'
	AND ' + @SatTableName + '.SatRecordHash != #' + @SatTableName + '.SatRecordHash;' +

'INSERT INTO ' + @SatTableName + '(' + @ColumnList + ') 
SELECT DISTINCT 
	' + @ModifiedColumns + '
FROM 
	#' + @SatTableName + ' 
LEFT JOIN ' + @SatTableName + ' 
	ON ' + @SatTableName + '.' + @SatPK + ' = #' + @SatTableName + '.' + @SatPK + '
	AND ' + @SatTableName + '.SatEndDate IS NULL
WHERE 
	' + @SatTableName + '.SatRecordSourceID IS NULL; ' +

'DROP TABLE #' + @SatTableName + ';'

print @sql

EXEC sp_executesql @sql;
;
end;
GO
