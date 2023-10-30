USE [gallery_exp]
GO
CREATE OR ALTER PROCEDURE [app].[sp_share_file_to_user]
    @id_file BIGINT
    ,@id_owner BIGINT
    ,@email_to_share VARCHAR(150)
AS
BEGIN
    DECLARE @contLinked SMALLINT;
    DECLARE @id_user BIGINT = 0;
    DECLARE @id_shared BIGINT = 0;
    SELECT [u].[id_user] INTO [id_user] FROM [app].[users] AS [u] WHERE [u].[email] = @email_to_share;
    
    IF(SELECT COUNT(*) FROM [app].files AS [f] WHERE [f].[id_file] = @id_file AND [f].[fk_user] != @id_owner) = 1
    BEGIN
        SELECT 404 AS "code" ,'ERROR: The user is not the Owner' AS "description";
        RETURN -1;
    END;

    IF (SELECT COUNT(*) FROM [app].[files] AS [f] WHERE [f].[id_file] = @id_file AND [f].[fk_user] = @id_user)>0
    BEGIN
        SELECT 404 AS "code" ,'ERROR: The user to share is the Owner' AS "description";
        RETURN -1;
    END;

    IF @id_user=0
    BEGIN
        SELECT 404 AS "code" ,'ERROR: Email not found' AS "description";
        RETURN -1;
    END;

    IF (SELECT COUNT(*) FROM [app].[shared_user] AS [su]
            WHERE [su].[fk_file] = @id_file AND [su].[fk_user] = @id_user) < 1
    BEGIN
        INSERT INTO [app].[shared_user] 
        ([fk_file]
        ,[fk_user]
        ,[status])
        VALUES (@id_file, @id_user, DEFAULT);
    END;

    SELECT @id_shared=[su].[id_shared_user] FROM [app].[shared_user] AS [su] WHERE [su].[fk_file] = @id_file AND [su].[fk_user] = @id_user;

    SELECT 200 AS "code" , CONCAT('SUCCESS: File Shared: ',@id_shared) AS "description";
    RETURN 1;
END;

-- EXAMPLE:
/*
EXEC [app].sp_share_file_to_user 1,'domain@.com';
*/