DELIMITER //
CREATE PROCEDURE gallery_exp.sp_update_user_pass(
    id_user BIGINT
    ,email VARCHAR(150)
    ,pass VARCHAR(35)
    ,new_pass VARCHAR(35)
)
proc_update_user_pass:BEGIN

    IF (SELECT COUNT(*) FROM gallery_exp.users AS u WHERE u.id_user = id_user AND u.fk_status = 0) < 1 THEN
        SELECT 404 AS "code" ,"ERROR: This user doesn't exist" AS "description";
        LEAVE proc_update_user_pass;
    END IF;

    IF (SELECT COUNT(*) FROM gallery_exp.users AS u WHERE u.id_user = id_user AND u.pass = pass AND u.email = email) < 1 THEN
        SELECT 400 AS "code" ,"ERROR: Wrong credentials" AS "description";
        LEAVE proc_update_user_pass;
    END IF;

    UPDATE gallery_exp.users AS u
    SET u.pass = new_pass
    WHERE u.id_user = id_user;

    SELECT 200 AS "code" ,'SUCCESS: Password changed' AS "description";
END;
