DELIMITER //
CREATE PROCEDURE gallery_exp.sp_update_user_name(
    id_user BIGINT
    ,email VARCHAR(150)
    ,pass VARCHAR(35)
    ,name VARCHAR(20)
)
proc_update_user_name:BEGIN

    IF (SELECT COUNT(*) FROM gallery_exp.users AS u WHERE u.id_user = id_user AND u.fk_status = 0) < 1 THEN
        SELECT 404 AS "code" ,"ERROR: This user doesn't exist" AS "description";
        LEAVE proc_update_user_name;
    END IF;

    IF (SELECT COUNT(*) FROM gallery_exp.users AS u WHERE u.name = name AND u.id_user = id_user) > 0 THEN
        SELECT 201 AS "code" ,'SUCCESS: User is the same' AS "description";
        LEAVE proc_update_user_name;
    END IF;

    IF (SELECT COUNT(*) FROM gallery_exp.users AS u WHERE u.id_user = id_user AND u.pass = pass AND u.email = email) < 1 THEN
        SELECT 400 AS "code" ,"ERROR: Wrong credentials" AS "description";
        LEAVE proc_update_user_name;
    END IF;

    UPDATE gallery_exp.users AS u
    SET u.name = name
    WHERE u.id_user = id_user;

    SELECT 200 AS "code" ,'SUCCESS: Name changed' AS "description";
END;
