DELIMITER //
CREATE PROCEDURE gallery_exp.sp_add_tag_to_file(
    id_tag BIGINT
    ,id_file BIGINT
)
proc_add_tag_to_file:BEGIN
	DECLARE id_file_tag BIGINT DEFAULT 0;
	IF (SELECT COUNT(*) FROM gallery_exp.files as f WHERE f.id_file = id_file) < 1 THEN
		SELECT 404 AS "code" ,'ERROR: File Not Found' AS "description";
        LEAVE proc_add_tag_to_file;
	END IF;

	IF (SELECT COUNT(*) FROM gallery_exp.tags AS t WHERE t.id_tag = id_tag) < 1 THEN
		SELECT 404 AS "code" ,'ERROR: Tag Not Found' AS "description";
        LEAVE proc_add_tag_to_file;
	END IF;
    
    IF (SELECT COUNT(*) FROM gallery_exp.file_tag
			WHERE fk_file = id_file
			AND fk_tag = id_tag)  = 0 THEN
        INSERT INTO gallery_exp.file_tag
		VALUES
		(
			DEFAULT
			,id_file
			,id_tag
			,DEFAULT
		);
	END IF;
    
	SELECT ft.id_file_tag INTO id_file_tag FROM gallery_exp.file_tag AS ft
	WHERE ft.fk_file = id_file
	AND ft.fk_tag = id_tag;
	
    SELECT 200 AS "code" ,CONCAT('SUCCESS: id=',id_file_tag) AS "description";
END;

-- EXAMPLE:
/*
CALL gallery_exp.sp_add_tag_to_file(1,1);
*/