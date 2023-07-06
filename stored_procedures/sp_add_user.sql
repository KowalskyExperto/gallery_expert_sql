CREATE OR REPLACE PROCEDURE [gallery_exp].[sp_add_user](
    email1 VARCHAR(125)
    ,pass1 VARCHAR(125)
    ,username1 VARCHAR(16)
    ,name1 VARCHAR(20)
    ,img_profile1 VARCHAR(256)
    ,apellido_paterno1 VARCHAR(30)
    ,apellido_materno1 VARCHAR(30)
)
AS $$
DECLARE
    contEmails SMALLINT:=0;
    contUsernames SMALLINT:=0;
BEGIN
    SELECT COUNT(*) INTO contEmails FROM [gallery_exp].[users] WHERE "email" = email1;
    SELECT COUNT(*) INTO contUsernames FROM [gallery_exp].[users] WHERE "username" = username1;
    
    IF contEmails < 1 AND contUsernames < 1 THEN
        INSERT INTO [gallery_exp].[users]
        VALUES 
        (
            DEFAULT
            ,2::SMALLINT
            ,email1
            ,pass1
            ,username1
            ,name1
            ,GETDATE()
            ,img_profile1
            ,apellido_paterno1
            ,apellido_materno1
        );
    END IF;
    
END; $$ LANGUAGE plpgsql;

-- EXAMPLE:
/*
CALL "gallery_exp"."sp_add_user"(
    'kowagogle1@gmail.com'
    ,'alfa1234
    ,'KowaGogle1'
    ,'Juan'
    ,NULL
    ,NULL
    ,NULL
)
*/