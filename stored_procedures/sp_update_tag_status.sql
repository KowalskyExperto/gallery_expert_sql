USE [gallery_exp]
GO
CREATE OR ALTER PROCEDURE [app].[sp_update_tag_status]
    @id_tag BIGINT
    ,@status SMALLINT
AS
BEGIN
    SET NOCOUNT ON
    IF (SELECT COUNT(*) FROM [app].[tags] AS [t] WHERE [t].[id_tag] = @id_tag) < 1
    BEGIN
        SELECT 400 AS "code" ,'ERROR: Tag ID doesn''t exists' AS "description";
        RETURN -1;
    END;

    UPDATE [app].[tags]
    SET [tags].[status] = @status
    WHERE [tags].[id_tag] = @id_tag;

    SELECT 200 AS "code" ,'SUCCESS: Tag Status changed' AS "description";
    RETURN 1;
END;