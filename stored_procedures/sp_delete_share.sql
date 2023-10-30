USE [gallery_exp]
GO
CREATE OR ALTER PROCEDURE [app].[sp_delete_share]
    @id_file BIGINT
    ,@id_owner BIGINT
    ,@email_to_share VARCHAR(150)
AS
BEGIN
    DECLARE @contLinked SMALLINT;
    DECLARE @id_user BIGINT = 0;
    DECLARE @id_shared BIGINT = 0;
    SELECT @id_user=[u].[id_user]  FROM [app].[users] AS [u] WHERE [u].[email] = @email_to_share;
    
    IF(SELECT COUNT(*) FROM [app].[files] AS [f] WHERE [f].[id_file] = @id_file AND [f].[fk_user] != @id_owner) = 1 
    BEGIN
        SELECT 404 AS "code" ,'ERROR: The user is not the Owner' AS "description";
        RETURN -1;
    END;
    
    IF @id_user=0
    BEGIN
        SELECT 404 AS "code" ,'ERROR: User to share not found' AS "description";
        RETURN -1;
    END;

    IF (SELECT COUNT(*) FROM [app].[shared_user] AS [su]
            WHERE [su].[fk_file] = @id_file AND [su].[fk_user] = @id_user) = 1
    BEGIN
        DELETE FROM [app].[shared_user] WHERE [shared_user].[fk_file] = @id_file AND [shared_user].[fk_user] = @id_user;
    END;

    IF (SELECT COUNT(*) FROM [app].[shared_user] AS [su] WHERE [su].[fk_file] = @id_file AND [su].[fk_user] = @id_user) = 0
    BEGIN
        SELECT 200 AS "code" , 'SUCCESS: File unshared' AS "description";
        RETURN 1;
    END;

    SELECT 400 AS "code" , 'ERROR: While delete sharing' AS "description";
    RETURN -1;
END;