USE [gallery_exp]
GO
CREATE OR ALTER PROCEDURE [app].[sp_update_user_apellido_materno]
    @id_user BIGINT
    ,@email VARCHAR(150)
    ,@pass VARCHAR(35)
    ,@apellido_paterno VARCHAR(30)
AS
BEGIN
    SET NOCOUNT ON
    IF (SELECT COUNT(*) FROM [app].[users] AS [u] WHERE [u].[id_user] = @id_user AND [u].[fk_status] = 0) < 1
    BEGIN
        SELECT 404 AS "code" ,'ERROR: This user doesn''t exist' AS "description";
        RETURN -1;
    END;

    IF (SELECT COUNT(*) FROM [app].[users] AS [u] WHERE [u].[id_user] = @id_user AND [u].[pass] = @pass AND [u].[email] = @email) < 1
    BEGIN
        SELECT 400 AS "code" ,'ERROR: Wrong credentials' AS "description";
        RETURN -1;
    END;

    UPDATE [app].[users]
    SET [users].[apellido_paterno] = @apellido_paterno
    WHERE [users].[id_user] = @id_user;

    SELECT 200 AS "code" ,'SUCCESS: Apellido Materno changed' AS "description";
    RETURN 1;
END;
