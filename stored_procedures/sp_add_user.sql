USE [gallery_exp]
GO
CREATE OR ALTER PROCEDURE [app].[sp_add_user]
    @email VARCHAR(125)
    ,@pass VARCHAR(125)
    ,@username VARCHAR(16)
    ,@name VARCHAR(20)
    ,@img_profile VARCHAR(256)
    ,@apellido_paterno VARCHAR(30)
    ,@apellido_materno VARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON
    DECLARE @contEmails INT, @contUsernames INT;

    SELECT @contEmails=COUNT(*) FROM [app].[users] AS u WHERE [u].[email] = @email;
    SELECT @contUsernames=COUNT(*) FROM [app].[users] AS u WHERE [u].[username] = @username;
    PRINT @contEmails
    IF(@contEmails >= 1) 
	BEGIN
        SELECT 400 AS "code" ,'ERROR: Email alredy exists' AS "description";
        RETURN -1;
    END;

    IF(@contUsernames >= 1)
	BEGIN
        SELECT 400 AS "code" ,'ERROR: Username alredy exists' AS "description";
        RETURN -1;
    END;
    
    INSERT INTO [app].[users] (
        [email]
        ,[pass]
        ,[username]
        ,[name]
        ,[img_profile]
        ,[apellido_paterno]
        ,[apellido_materno])
    VALUES 
    (
        @email
        ,@pass
        ,@username
        ,@name
        ,@img_profile
        ,@apellido_paterno
        ,@apellido_materno
    );
END;
-- EXAMPLE:
/*
USE [gallery_exp];
GO
EXEC [app].[sp_add_user]
    'kowalskyexperto@gmail.com'
    ,'alfa12234'
    ,'KowaGogle1'
    ,'Juan'
    ,NULL
    ,NULL
    ,NULL
;
*/