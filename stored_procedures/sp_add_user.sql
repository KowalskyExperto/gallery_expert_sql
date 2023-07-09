USE gallery_exp;
DELIMITER //
CREATE PROCEDURE gallery_exp.sp_add_user(
    email VARCHAR(125)
    ,pass VARCHAR(125)
    ,username VARCHAR(16)
    ,name VARCHAR(20)
    ,img_profile VARCHAR(256)
    ,apellido_paterno VARCHAR(30)
    ,apellido_materno VARCHAR(30)
)
proc:BEGIN
    DECLARE contEmails, contUsernames INT;

    SELECT COUNT(*) INTO contEmails FROM gallery_exp.users as u WHERE u.email = email;
    SELECT COUNT(*) INTO contUsernames FROM gallery_exp.users as u WHERE u.username = username;

    IF(contEmails >= 1) THEN
        SELECT 400 AS "code" ,'Email alredy exists' AS "description";
        LEAVE proc;
    END IF;

    IF(contUsernames >= 1) THEN
        SELECT 400 AS "code" ,'Username alredy exists' AS "description";
        LEAVE proc;
    END IF;
    
    INSERT INTO gallery_exp.users
    VALUES 
    (
        DEFAULT
        ,2
        ,email
        ,pass
        ,username
        ,name
        ,NOW()
        ,img_profile
        ,apellido_paterno
        ,apellido_materno
    );
END;
-- EXAMPLE:
/*
CALL gallery_exp.sp_add_user(
    'kowalskyexperto@gmail.com'
    ,'alfa12234'
    ,'KowaGogle1'
    ,'Juan'
    ,NULL
    ,NULL
    ,NULL
);
*/