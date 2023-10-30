USE [gallery_exp]
GO
CREATE OR ALTER PROCEDURE [app].[sp_update_tag_name]
    @id_tag BIGINT
    ,@name VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON
    IF (SELECT COUNT(*) FROM [app].[tags] AS [t] WHERE [t].[name] = @name AND [t].[id_tag] = @id_tag) > 0
    BEGIN
        SELECT 201 AS "code" ,'SUCCESS: The tag name is the same' AS "description";
        RETURN -1;
    END;

    IF (SELECT COUNT(*) FROM [app].[tags] AS [t] WHERE [t].[name] = @name) > 0
    BEGIN
        SELECT 400 AS "code" ,'ERROR: Tag with that name alredy exist' AS "description";
        RETURN -1;
    END;

    IF (SELECT COUNT(*) FROM [app].[tags] AS [t] WHERE [t].[id_tag] = @id_tag) < 1
    BEGIN
        SELECT 404 AS "code" ,'ERROR: Tag ID doesn''t exists' AS "description";
        RETURN -1;
    END;

    UPDATE [app].[tags]
    SET [tags].[name] = @name
    WHERE [tags].[id_tag] = @id_tag;

    SELECT 200 AS "code" ,'SUCCESS: Tag renamed' AS "description";
    RETURN 1;
END;

-- EXAMPLE
/*
EXEC [app].[sp_update_tag_name] 1,'feo';
*/