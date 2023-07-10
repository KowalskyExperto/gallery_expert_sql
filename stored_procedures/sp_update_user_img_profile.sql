DELIMITER //
CREATE PROCEDURE gallery_exp.sp_update_user_img_profile(
    id_user BIGINT
    ,img_profile VARCHAR(35)
)
proc_update_user_img_profile:BEGIN

    IF (SELECT COUNT(*) FROM gallery_exp.users AS u WHERE u.id_user = id_user AND u.fk_status = 0) < 1 THEN
        SELECT 404 AS "code" ,"ERROR: This user doesn't exist" AS "description";
        LEAVE proc_update_user_img_profile;
    END IF;

    UPDATE gallery_exp.users AS u
    SET u.img_profile = img_profile
    WHERE u.id_user = id_user;

    SELECT 200 AS "code" ,'SUCCESS: Image Profile updated' AS "description";
END;
