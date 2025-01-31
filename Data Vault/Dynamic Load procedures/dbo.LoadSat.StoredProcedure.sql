USE [model]
GO
/****** Object:  StoredProcedure [dbo].[LoadSat]    Script Date: 8/2/2023 1:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LoadSat]
(
    @SatTableName NVARCHAR(255)
)
AS
SET NOCOUNT OFF

BEGIN

--DECLARE @SatTableName NVARCHAR(255);
--SET @SatTableName = 'SAT_Appearances';

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

    -- Stage lentele
    SET @SatStageTableName = REPLACE(@SatTableName, 'SAT_', 'stage.');
	--print @SatStageTableName

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


	--PK is stage lenteles
	select top 1 @StagePK = name
	from sys.columns
	WHERE object_id = OBJECT_ID(@SatStageTableName);
	--print(@StagePK);


	-- stage column listai
	SELECT @StageColumnList = @StageColumnList + QUOTENAME(name) + ','
    FROM sys.columns
    WHERE object_id = OBJECT_ID(@SatStageTableName);
    SET @StageColumnList = LEFT(@StageColumnList, LEN(@StageColumnList) - 1);
	--print @StageColumnList;


	--- stage column templist

	INSERT INTO @TempStageColumns (StageColumnName)
	SELECT TRIM(VALUE) AS StageColumnName
	FROM STRING_SPLIT(@StageColumnList, @StageDelimiter);

	UPDATE @TempStageColumns
	SET StageColumnName = 'UPPER(' + StageColumnName + ')';

	SELECT @StageModifiedColumns = STRING_AGG(StageColumnName, @StageDelimiter)
	FROM @TempStageColumns;

	--print @StageModifiedColumns;

	---PK is Sat lenteles

	select top 1 @SatPK = name
	from sys.columns
	WHERE object_id = OBJECT_ID(@SatTableName);
	--print(@SatPK);

DECLARE @sql NVARCHAR(MAX);

SET @sql = N'
CREATE TABLE #' + @SatTableName +
'(' + @listas + '); ' +

'INSERT INTO #' + @SatTableName + ' (' + @ColumnList + ') 
SELECT
	  CONVERT(NVARCHAR(128), HASHBYTES(''MD5'', CONVERT(NVARCHAR(128), UPPER(' + @StagePK + '))), 2),
	  GETDATE(),
	  NULL,
	  CONVERT(NVARCHAR(128), HASHBYTES(''MD5'', ''' + @SatStageTableName + '''), 2),
	  CONVERT(NVARCHAR(128), HASHBYTES(''MD5'', CONCAT(' + @StageModifiedColumns + ')), 2),'
	  + @StageColumnList + '
FROM ' + @SatStageTableName + ';' +

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

'DROP TABLE #' + @SatTableName + ';';

--PRINT @sql;

EXEC sp_executesql @sql;

end;
GO
