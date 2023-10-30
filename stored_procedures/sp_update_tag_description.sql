USE [gallery_exp]
GO
CREATE OR ALTER PROCEDURE [app].[sp_update_tag_description]
    @id_tag BIGINT
    ,@description VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON
     IF (SELECT COUNT(*) FROM [app].[tags] AS [t] WHERE [t].[id_tag] = @id_tag AND [t].[status] = 1) < 1
     BEGIN
        SELECT 400 AS "code" ,'ERROR: Tag ID doesn''t exists' AS "description";
        RETURN -1;
    END;

    UPDATE [app].[tags]
    SET [tags].[description] = @description
    WHERE [tags].[id_tag] = @id_tag;

    SELECT 200 AS "code" ,'SUCCESS: Tag renamed' AS "description";
    RETURN 0;
END;

-- EXAMPLE
/*
EXEC [app].sp_update_tag 1,'feo';
*/