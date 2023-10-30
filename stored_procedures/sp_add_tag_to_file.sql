USE [gallery_exp]
GO
CREATE OR ALTER PROCEDURE [app].[sp_add_tag_to_file]
    @id_tag BIGINT
    ,@id_file BIGINT
AS
BEGIN
	DECLARE @id_file_tag BIGINT = 0;
	IF (SELECT COUNT(*) FROM [app].[files] as [f] WHERE [f].[id_file] = @id_file) < 1
	BEGIN
		SELECT 404 AS "code" ,'ERROR: File Not Found' AS "description";
        RETURN -1;
	END;

	IF (SELECT COUNT(*) FROM [app].[tags] AS [t] WHERE [t].[id_tag] = @id_tag) < 1
	BEGIN
		SELECT 404 AS "code" ,'ERROR: Tag Not Found' AS "description";
        RETURN -1;
	END;
    
    IF (SELECT COUNT(*) FROM [app].[file_tag]
			WHERE [fk_file] = @id_file
			AND [fk_tag] = @id_tag)  = 0 
	BEGIN
        INSERT INTO [app].[file_tag]
		(
			[fk_file]
			,[fk_tag]
			,[status]
		)
		VALUES
		(
			@id_file
			,@id_tag
			,DEFAULT
		);
	END;
    
	SELECT [ft].[id_file_tag] INTO [id_file_tag] FROM [app].[file_tag] AS [ft]
	WHERE ft.[fk_file] = @id_file
	AND ft.[fk_tag] = @id_tag;
	
    SELECT 200 AS "code" ,CONCAT('SUCCESS: id=',@id_file_tag) AS "description";
END;

-- EXAMPLE:
/*
CALL [app].sp_add_tag_to_file(1,1);
*/