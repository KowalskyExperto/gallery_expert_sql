DELIMITER //
CREATE PROCEDURE gallery_exp.sp_update_user_apellido_paterno(
    id_user BIGINT
    ,email VARCHAR(150)
    ,pass VARCHAR(35)
    ,apellido_paterno VARCHAR(30)
)
proc_update_user_apellido_paterno:BEGIN

    IF (SELECT COUNT(*) FROM gallery_exp.users AS u WHERE u.id_user = id_user AND u.fk_status = 0) < 1 THEN
        SELECT 404 AS "code" ,"ERROR: This user doesn't exist" AS "description";
        LEAVE proc_update_user_apellido_paterno;
    END IF;

    IF (SELECT COUNT(*) FROM gallery_exp.users AS u WHERE u.id_user = id_user AND u.pass = pass AND u.email = email) < 1 THEN
        SELECT 400 AS "code" ,"ERROR: Wrong credentials" AS "description";
        LEAVE proc_update_user_apellido_paterno;
    END IF;

    UPDATE gallery_exp.users AS u
    SET u.apellido_paterno = apellido_paterno
    WHERE u.id_user = id_user;

    SELECT 200 AS "code" ,'SUCCESS: Apellido Paterno changed' AS "description";
END;
