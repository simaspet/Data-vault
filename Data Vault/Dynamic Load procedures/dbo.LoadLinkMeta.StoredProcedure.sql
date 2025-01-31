USE [model]
GO
/****** Object:  StoredProcedure [dbo].[LoadLinkMeta]    Script Date: 8/8/2023 3:15:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LoadLinkMeta]
(
	@linkTableName NVARCHAR(255)
)
AS
SET NOCOUNT OFF

BEGIN

DECLARE @ColumnList NVARCHAR(MAX);
DECLARE @StageColumnList1UPPER NVARCHAR(MAX);
DECLARE @StagePKUPPER NVARCHAR(MAX);
DECLARE @StageTable NVARCHAR(MAX);
DECLARE @StageColumnList1 NVARCHAR(MAX);
DECLARE @StagePK NVARCHAR(MAX);
DECLARE @sql NVARCHAR(MAX);
DECLARE @LinkPK NVARCHAR(MAX);

SET @ColumnList = '';

--DECLARE @LinkTableName NVARCHAR(255);
--SET @LinkTableName = 'LINK_PlayersPlayerValuations';

SELECT md.*, lm.PK AS SecondTablePK
FROM [stage].[MetaDataTable] md
JOIN stage.LinkMapKey lm ON md.StageTable = lm.StageTable
WHERE lm.LinkTable = @LinkTableName;


	--LINK pk
	SELECT TOP 1 @LinkPK = @ColumnList + QUOTENAME(name) + ','
    FROM sys.columns
    WHERE object_id = OBJECT_ID(@LinkTableName);
    SET @LinkPK = LEFT(@LinkPK, LEN(@LinkPK) - 1)
	--print @LinkPK;

    -- Column listai
    SELECT @ColumnList = @ColumnList + QUOTENAME(name) + ','
    FROM sys.columns
    WHERE object_id = OBJECT_ID(@LinkTableName);
    SET @ColumnList = LEFT(@ColumnList, LEN(@ColumnList) - 1);
	--print @ColumnList;


	SELECT @StageColumnList1 = 
    CASE 
        WHEN LEN(md.StageColumn3) > 0 THEN 'CONVERT(VARCHAR(128),s.' + md.StageColumn1 + ') + CONVERT(VARCHAR(128),s.' + md.StageColumn2 + ') + CONVERT(VARCHAR(128),s.' + md.StageColumn3
        WHEN LEN(md.StageColumn2) > 0 THEN 'CONVERT(VARCHAR(128),s.' + md.StageColumn1 + ') + CONVERT(VARCHAR(128),s.' + md.StageColumn2
        ELSE 'CONVERT(VARCHAR(128),s.' + md.StageColumn1
    END
FROM stage.MetaDataTable md
JOIN stage.LinkMapKey lm ON md.StageTable = lm.StageTable
WHERE lm.LinkTable = @LinkTableName;

SELECT @StageColumnList1UPPER = 
    CASE 
        WHEN LEN(md.StageColumn3) > 0 THEN 'CONVERT(VARCHAR(128),UPPER(s.' + md.StageColumn1 + '))+ CONVERT(VARCHAR(128),UPPER(s.' + md.StageColumn2 + ')) +CONVERT(VARCHAR(128),UPPER(s.' + md.StageColumn3 + '))'
        WHEN LEN(md.StageColumn2) > 0 THEN 'CONVERT(VARCHAR(128),UPPER(s.' + md.StageColumn1 + '))+ CONVERT(VARCHAR(128),UPPER(s.' + md.StageColumn2 + '))'
        ELSE 'CONVERT(VARCHAR(128),UPPER(s.' + md.StageColumn1 + '))'
    END
FROM stage.MetaDataTable md
JOIN stage.LinkMapKey lm ON md.StageTable = lm.StageTable
WHERE lm.LinkTable = @LinkTableName;

--PRINT @StageColumnList1UPPER;

SELECT @StagePKUPPER = 'CONVERT(VARCHAR(128),UPPER(s.' + lm.PK + '))'
FROM stage.MetaDataTable md
JOIN stage.LinkMapKey lm ON md.StageTable = lm.StageTable
WHERE lm.LinkTable = @LinkTableName;
--print @StagePKUPPER;

SELECT @StagePK = 'CONVERT(VARCHAR(128),s.' + lm.PK + ')'
FROM stage.MetaDataTable md
JOIN stage.LinkMapKey lm ON md.StageTable = lm.StageTable
WHERE lm.LinkTable = @LinkTableName;
--print @StagePK;

SELECT @StageTable = 'stage.'+md.StageTable
FROM stage.MetaDataTable md
JOIN stage.LinkMapKey lm ON md.StageTable = lm.StageTable
WHERE lm.LinkTable = @LinkTableName;
--print @StageTable;


SET @sql = N'
    
    INSERT INTO ' + @LinkTableName + ' (' + @ColumnList + ')
    SELECT 
        CONVERT(NVARCHAR(128), HASHBYTES(''MD5'', ' + @StageColumnList1UPPER  +'+'+@StagePKUPPER+ '), 2),
        CONVERT(NVARCHAR(128), HASHBYTES(''MD5'', ' + @StagePKUPPER + '), 2),
        CONVERT(NVARCHAR(128), HASHBYTES(''MD5'', ' + @StageColumnList1UPPER + '), 2),
        CONVERT(NVARCHAR(128), HASHBYTES(''MD5'', CONVERT(VARCHAR(128), ''' + @StageTable + ''')), 2),
        GETDATE(),
        ' +@StagePK + ',
        ' +@StageColumnList1+')
    FROM ' + @StageTable + ' AS s
	WHERE NOT EXISTS
	(SELECT *
	FROM '+@LinkTableName+' AS LINK
	WHERE LINK.'+@LinkPK+ '= '+ 'CONVERT(NVARCHAR(128), HASHBYTES(''MD5'', ' + @StageColumnList1UPPER  +'+'+@StagePKUPPER+ '), 2)
	)'
	
	PRINT @sql;
	EXEC sp_executesql @sql
end;
GO
