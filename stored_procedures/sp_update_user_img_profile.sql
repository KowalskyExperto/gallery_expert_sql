USE [gallery_exp]
GO
CREATE OR ALTER PROCEDURE [app].[sp_update_user_img_profile]
    @id_user BIGINT
    ,@img_profile VARCHAR(35)
AS
BEGIN
    SET NOCOUNT ON
    IF (SELECT COUNT(*) FROM [app].[users] AS [u] WHERE [u].[id_user] = @id_user AND [u].[fk_status] = 0) < 1
    BEGIN
        SELECT 404 AS "code" ,'ERROR: This user doesn''t exist' AS "description";
        RETURN -1;
    END;

    UPDATE [app].[users]
    SET [users].[img_profile] = @img_profile
    WHERE [users].[id_user] = @id_user;

    SELECT 200 AS "code" ,'SUCCESS: Image Profile updated' AS "description";
    RETURN -1;
END;
