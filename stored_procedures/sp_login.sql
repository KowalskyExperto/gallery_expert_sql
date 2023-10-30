USE [gallery_exp]
GO
CREATE OR ALTER PROCEDURE [app].[sp_login]
    @email VARCHAR(150)
    ,@pass VARCHAR(35)
AS
BEGIN
    SET NOCOUNT ON
   	DECLARE @loginFailed SMALLINT = 0;
    
    IF (SELECT COUNT(*) FROM [app].[users] AS u, [app].[status] as s  WHERE u.[email] LIKE @email and u.[fk_status]=s.[id_status] and s.[status] LIKE 'PENDING') = 1
	BEGIN
		SELECT 400 AS "code" ,'ERROR: User not activated' AS "description";
        RETURN -1;
	END;

	IF (SELECT COUNT(*) FROM [app].[users] AS u WHERE u.[email] = @email AND u.[pass] = @pass) = 0
    BEGIN
        SELECT 400 AS "code" ,'ERROR: Login Error' AS "description";
        RETURN -1;
	END;

    SELECT 200 AS "code" ,'SUCCESS: Valid Login' AS "description";
END;

-- EXAMPLE:
/*
EXEC [app].[sp_login] 'mail@.com','pass';
*/
