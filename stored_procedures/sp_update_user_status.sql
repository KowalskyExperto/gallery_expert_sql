USE [gallery_exp]
GO
CREATE OR ALTER PROCEDURE [app].[sp_update_user_status]
    @id_user BIGINT
    ,@status SMALLINT
AS
BEGIN
    SET NOCOUNT ON
    IF (SELECT COUNT(*) FROM [app].[users] AS [u] WHERE [u].[id_user] = @id_user) < 1 
    BEGIN
        SELECT 404 AS "code" ,'ERROR: This user doesn''t exist' AS "description";
        RETURN -1;
    END;

    UPDATE [app].[users]
    SET [users].[fk_status] = @status
    WHERE [users].[id_user] = @id_user;

    SELECT 200 AS "code" ,'SUCCESS: Status changed' AS "description";
END;
