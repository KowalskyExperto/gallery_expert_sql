USE [gallery_exp]
GO
CREATE OR ALTER PROCEDURE [app].[sp_add_tag]
    @name VARCHAR(50)
    ,@description VARCHAR(100)
AS
BEGIN
    DECLARE @contName SMALLINT;
    SELECT @contName=COUNT(*) FROM [app].[tags] AS [t] WHERE [t].[name] = @name;
    IF @contName < 1
    BEGIN
        INSERT INTO [app].[tags]
        (
            [name]
            ,[description]
            ,[created_at]
            ,[count]
            ,[status]
        )
        VALUES
        (
            @name
            ,@description
            ,GETDATE()
            ,DEFAULT
            ,DEFAULT
        );
    END;
END;

--EXAMPLE:
/*
EXEC [app].[sp_add_tag]
    'bonito'
    ,'Cosas bonitas XD'
*/