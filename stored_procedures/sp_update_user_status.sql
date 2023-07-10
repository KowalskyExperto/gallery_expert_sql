DELIMITER //
CREATE PROCEDURE gallery_exp.sp_update_user_status(
    id_user BIGINT
    ,status SMALLINT
)
proc_update_user_status:BEGIN

    IF (SELECT COUNT(*) FROM gallery_exp.users AS u WHERE u.id_user = id_user) < 1 THEN
        SELECT 404 AS "code" ,"ERROR: This user doesn't exist" AS "description";
        LEAVE proc_update_user_status;
    END IF;

    UPDATE gallery_exp.users AS u
    SET u.fk_status = status
    WHERE u.id_user = id_user;

    SELECT 200 AS "code" ,'SUCCESS: Status changed' AS "description";
END;
