DELIMITER //
CREATE PROCEDURE gallery_exp.sp_update_tag_name(
    id_tag BIGINT
    ,name VARCHAR(50)
)
proc_update_tag_name:BEGIN
    IF (SELECT COUNT(*) FROM gallery_exp.tags AS t WHERE t.name = name AND t.id_tag = id_tag) > 0 THEN
        SELECT 201 AS "code" ,'SUCCESS: The tag name is the same' AS "description";
        LEAVE proc_update_tag_name;
    END IF;

    IF (SELECT COUNT(*) FROM gallery_exp.tags AS t WHERE t.name = name) > 0 THEN
        SELECT 400 AS "code" ,'ERROR: Tag with that name alredy exist' AS "description";
        LEAVE proc_update_tag_name;
    END IF;

    IF (SELECT COUNT(*) FROM gallery_exp.tags AS t WHERE t.id_tag = id_tag) < 1 THEN
        SELECT 404 AS "code" ,"ERROR: Tag ID doesn't exists" AS "description";
        LEAVE proc_update_tag_name;
    END IF;

    UPDATE gallery_exp.tags AS t
    SET t.name = name
    WHERE t.id_tag = id_tag;

    SELECT 200 AS "code" ,'SUCCESS: Tag renamed' AS "description";
END;

-- EXAMPLE
/*
CALL gallery_exp.sp_update_tag(1,'feo');
*/