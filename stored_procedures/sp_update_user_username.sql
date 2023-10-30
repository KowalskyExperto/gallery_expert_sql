USE [gallery_exp]
GO
CREATE OR ALTER PROCEDURE [app].[sp_update_user_username]
    @id_user BIGINT
    ,@username VARCHAR(16)
    ,@email VARCHAR(150)
    ,@pass VARCHAR(35)
AS
BEGIN
    SET NOCOUNT ON
    IF (SELECT COUNT(*) FROM [app].[users] AS [u] WHERE [u].[id_user] = @id_user AND [u].[fk_status] = 0) < 1 
    BEGIN
        SELECT 404 AS "code" ,'ERROR: This user doesn''t exist' AS "description";
        RETURN -1;
    END;
    
    IF (SELECT COUNT(*) FROM [app].[users] AS [u] WHERE [u].[username] = @username AND [u].[id_user] = @id_user) > 0 
    BEGIN
        SELECT 201 AS "code" ,'SUCCESS: The Username is the same' AS "description";
        RETURN 0;
    END;

    IF (SELECT COUNT(*) FROM [app].[users] AS [u] WHERE [u].[username] = @username) > 0 
    BEGIN
        SELECT 400 AS "code" ,'ERROR: That username alredy is in use' AS "description";
        RETURN -1;
    END;


    IF (SELECT COUNT(*) FROM [app].[users] AS [u] WHERE [u].[id_user] = @id_user AND [u].[pass] = @pass AND [u].[email] = @email) < 1 
    BEGIN
        SELECT 400 AS "code" ,'ERROR: Wrong credentials' AS "description";
        RETURN -1;
    END;

    UPDATE [app].[users]
    SET [users].[username] = @username
    WHERE [users].[id_user] = @id_user;

    SELECT 200 AS "code" ,'SUCCESS: Username changed' AS "description";
    RETURN 1;
END;
