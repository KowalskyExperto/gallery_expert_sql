DELIMITER //
CREATE PROCEDURE gallery_exp.sp_add_tag_to_file(
    id_tag BIGINT
    ,id_file BIGINT
)
BEGIN
    DECLARE contLinked SMALLINT;
   	DECLARE existFile BOOL DEFAULT FALSE;
	DECLARE existTag BOOL DEFAULT FALSE;

	IF (SELECT COUNT(*) FROM gallery_exp.files WHERE id_file = id_file) = 0 THEN
		SELECT 404 AS "code" ,'File Not Found' AS "description";
	END IF;

	IF (SELECT COUNT(*) FROM gallery_exp.tags WHERE id_tag = id_tag) = 0 THEN
		SELECT 404 AS "code" ,'Tag Not Found' AS "description";
	END IF;
	
    SELECT COUNT(*) INTO contLinked FROM gallery_exp.file_tag
    WHERE fk_file = id_file1
    AND fk_tag = id_tag1;

    IF contLinked < 1 THEN
        INSERT INTO gallery_exp.file_tag
        VALUES
        (
            DEFAULT
            ,id_file1
            ,id_tag1
        );
       SELECT id_file_tag FROM gallery_exp.file_tag
	    WHERE fk_file = id_file1
	    AND fk_tag = id_tag1;
    END IF;
END;

-- EXAMPLE:
/*
CALL gallery_exp.sp_add_tag_to_file(1,1);
*/