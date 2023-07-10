DELIMITER //
CREATE PROCEDURE gallery_exp.sp_update_tag_description(
    id_tag BIGINT
    ,description VARCHAR(100)
)
proc_update_tag_name:BEGIN

     IF (SELECT COUNT(*) FROM gallery_exp.tags AS t WHERE t.id_tag = id_tag AND t.status = TRUE) < 1 THEN
        SELECT 400 AS "code" ,"ERROR: Tag ID doesn't exists" AS "description";
        LEAVE proc_update_tag_name;
    END IF;

    UPDATE gallery_exp.tags AS t
    SET t.description = description
    WHERE t.id_tag = id_tag;

    SELECT 200 AS "code" ,'SUCCESS: Tag renamed' AS "description";
END;

-- EXAMPLE
/*
CALL gallery_exp.sp_update_tag(1,'feo');
*/