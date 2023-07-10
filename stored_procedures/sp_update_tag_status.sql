DELIMITER //
CREATE PROCEDURE gallery_exp.sp_update_tag_status(
    id_tag BIGINT
    ,status SMALLINT
)
proc_update_tag_name:BEGIN

     IF (SELECT COUNT(*) FROM gallery_exp.tags AS t WHERE t.id_tag = id_tag AND t.status = TRUE) < 1 THEN
        SELECT 400 AS "code" ,"ERROR: Tag ID doesn't exists" AS "description";
        LEAVE proc_update_tag_name;
    END IF;

    UPDATE gallery_exp.tags AS t
    SET t.status = status
    WHERE t.id_tag = id_tag;

    SELECT 200 AS "code" ,'SUCCESS: Tag Status changed' AS "description";
END;