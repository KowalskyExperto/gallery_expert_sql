DELIMITER //
CREATE PROCEDURE gallery_exp.sp_update_user_username(
    id_user BIGINT
    ,username VARCHAR(16)
    ,email VARCHAR(150)
    ,pass VARCHAR(35)
)
proc_update_user_username:BEGIN

    IF (SELECT COUNT(*) FROM gallery_exp.users AS u WHERE u.id_user = id_user AND u.fk_status = 0) < 1 THEN
        SELECT 404 AS "code" ,"ERROR: This user doesn't exist" AS "description";
        LEAVE proc_update_user_username;
    END IF;
    
    IF (SELECT COUNT(*) FROM gallery_exp.users AS u WHERE u.username = username AND u.id_user = id_user) > 0 THEN
        SELECT 201 AS "code" ,'SUCCESS: The Username is the same' AS "description";
        LEAVE proc_update_user_username;
    END IF;

    IF (SELECT COUNT(*) FROM gallery_exp.users AS u WHERE u.username = username) > 0 THEN
        SELECT 400 AS "code" ,'ERROR: That username alredy is in use' AS "description";
        LEAVE proc_update_user_username;
    END IF;


    IF (SELECT COUNT(*) FROM gallery_exp.users AS u WHERE u.id_user = id_user AND u.pass = pass AND u.email = email) < 1 THEN
        SELECT 400 AS "code" ,"ERROR: Wrong credentials" AS "description";
        LEAVE proc_update_user_username;
    END IF;

    UPDATE gallery_exp.users AS u
    SET u.username = username
    WHERE u.id_user = id_user;

    SELECT 200 AS "code" ,'SUCCESS: Username changed' AS "description";
END;
