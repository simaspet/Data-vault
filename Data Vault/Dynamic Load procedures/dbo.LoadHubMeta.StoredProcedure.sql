USE [model]
GO
/****** Object:  StoredProcedure [dbo].[LoadHubMeta]    Script Date: 8/8/2023 3:15:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	CREATE PROCEDURE [dbo].[LoadHubMeta]
	(
		@HubTableName NVARCHAR(255)
	)
	AS
	SET NOCOUNT OFF

	BEGIN


	DECLARE @columnlist NVARCHAR(MAX);
	DECLARE @PrimaryKeyListUPPER NVARCHAR(128);
	DECLARE @stagePK NVARCHAR(128);
	DECLARE @PrimaryKeyList NVARCHAR(128);
	DECLARE @TableNameForStage NVARCHAR(128);
	DECLARE @sql NVARCHAR(MAX);
	DECLARE @HubPK1 NVARCHAR(128);
	DECLARE @HubPK2 NVARCHAR(128);
	DECLARE @HubPK3 NVARCHAR(128);
	DECLARE @StagePK1 NVARCHAR(128);
	DECLARE @StagePK2 NVARCHAR(128);
	DECLARE @StagePK3 NVARCHAR(128);


	--DECLARE @HubTableName NVARCHAR(255);
	--SET @HubTableName = 'HUB_PlayerValuations';
select *
FROM sys.columns JOIN sys.tables ON sys.columns.object_id = sys.tables.object_id 
						WHERE sys.tables.name = @hubTableName

	SET @columnlist = ( SELECT STRING_AGG(QUOTENAME(sys.columns.name), ',') 
						FROM sys.columns JOIN sys.tables ON sys.columns.object_id = sys.tables.object_id 
						WHERE sys.tables.name = @hubTableName)
	--print @columnlist

SET @PrimaryKeyListUPPER = (
    SELECT STRING_AGG(
        CASE WHEN LEN(StageColumn1) > 0 THEN 'UPPER(' + StageColumn1 + ')' ELSE '' END
        + CASE WHEN LEN(StageColumn2) > 0 AND LEN(StageColumn1) > 0 THEN '+UPPER(' + StageColumn2 + ')' ELSE '' END
        + CASE WHEN LEN(StageColumn3) > 0 AND (LEN(StageColumn1) > 0 OR LEN(StageColumn2) > 0) THEN '+UPPER(' + StageColumn3 + ')' ELSE '' END,
        '+'
    )
    FROM stage.MetaDataTable
    WHERE HubTable = @HubTableName -- Add this condition to select only one row per @HubTableName
);

PRINT @PrimaryKeyListUPPER;

SET @PrimaryKeyList = (
    SELECT STRING_AGG(
        CASE WHEN LEN(StageColumn1) > 0 THEN StageColumn1 ELSE '' END
        + CASE WHEN LEN(StageColumn2) > 0 AND LEN(StageColumn1) > 0 THEN ',' + StageColumn2 ELSE '' END
        + CASE WHEN LEN(StageColumn3) > 0 AND (LEN(StageColumn1) > 0 OR LEN(StageColumn2) > 0) THEN ',' + StageColumn3 ELSE '' END,
        ','
    )
    FROM stage.MetaDataTable
    WHERE HubTable = @HubTableName -- Add this condition to select only one row per @HubTableName
    AND (HubColumn1 IN (
            SELECT a.name
            FROM sys.columns a
            JOIN sys.tables b ON a.object_id = b.object_id
            WHERE b.name = @HubTableName
        )
        OR LEN(HubColumn1) = 0
    )
    AND (HubColumn2 IN (
            SELECT a.name
            FROM sys.columns a
            JOIN sys.tables b ON a.object_id = b.object_id
            WHERE b.name = @HubTableName
        )
        OR LEN(HubColumn2) = 0
    )
    AND (HubColumn3 IN (
            SELECT a.name
            FROM sys.columns a
            JOIN sys.tables b ON a.object_id = b.object_id
            WHERE b.name = @HubTableName
        )
        OR LEN(HubColumn3) = 0
    )
);

PRINT @PrimaryKeyList;

SET @HubPK1 = (
    SELECT HubColumn1 
    FROM [stage].MetaDataTable 
    WHERE HubTable LIKE @HubTableName
);
--PRINT @HubPK1;

SET @HubPK2 = (
    SELECT HubColumn2
    FROM [stage].MetaDataTable 
    WHERE HubTable LIKE @HubTableName
);
--PRINT @HubPK2;

SET @HubPK3 = (
    SELECT HubColumn3
    FROM [stage].MetaDataTable 
    WHERE HubTable LIKE @HubTableName
);
--PRINT @HubPK3;

SET @StagePK1 = (
    SELECT StageColumn1
    FROM [stage].MetaDataTable 
    WHERE HubTable LIKE @HubTableName
);
--PRINT @StagePK1;

SET @StagePK2 = (
    SELECT StageColumn2
    FROM [stage].MetaDataTable 
    WHERE HubTable LIKE @HubTableName
);
--PRINT @StagePK2;

SET @StagePK3 = (
    SELECT StageColumn3
    FROM [stage].MetaDataTable 
    WHERE HubTable LIKE @HubTableName
);
--PRINT @StagePK3;

SET @TableNameForStage = (SELECT StageTable FROM [stage].[MetaDataTable] WHERE HubTable = @hubTableName);
--print @TableNameForStage;

------------------------------------------------------------------------------------------

SET @sql = N'
    INSERT INTO ' + @HubTableName + ' (' + @ColumnList + ') 
    SELECT 
        CONVERT(NVARCHAR(128), HASHBYTES(''MD5'', CONVERT(varchar(128),' + @PrimaryKeyListUPPER + ')), 2),
        CONVERT(NVARCHAR(128), HASHBYTES(''MD5'', ''stage.' + @TableNameForStage + '''), 2),
        GETDATE(),
        ' + @PrimaryKeyList + '
    FROM stage.' + @TableNameForStage + ' AS s
    WHERE NOT EXISTS (
        SELECT 1 
        FROM ' + @HubTableName + ' AS Hub 
        WHERE Hub.' + @HubPK1 + ' = s.' + @StagePK1;

	-- kai yra 2PK
	IF len(@HubPK2) >0
	BEGIN
		SET @sql += ' AND Hub.' + @HubPK2 + ' = s.' + @StagePK2;
	END
	-- kai yra 3PK
	IF len(@HubPK3) >0
	BEGIN
		SET @sql += ' AND Hub.' + @HubPK3 + ' = s.' + @StagePK3;
	END

	SET @sql += ')';

	print @sql
    EXEC sp_executesql @sql;

end;
GO
