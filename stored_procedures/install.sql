USE gallery_exp;

-- Stored Procedure Add User
DELIMITER //
CREATE PROCEDURE gallery_exp.sp_add_user(
    email VARCHAR(125)
    ,pass VARCHAR(125)
    ,username VARCHAR(16)
    ,name VARCHAR(20)
    ,img_profile VARCHAR(256)
    ,apellido_paterno VARCHAR(30)
    ,apellido_materno VARCHAR(30)
)
BEGIN
    -- DECLARE contEmails, contUsernames INT;

    -- SELECT COUNT(*) INTO contEmails FROM gallery_exp.users WHERE "email" = email;
    -- SELECT COUNT(*) INTO contUsernames FROM gallery_exp.users WHERE "username" = username;
    
    -- IF contEmails < 1 AND contUsernames < 1 THEN
        INSERT INTO gallery_exp.users
        VALUES 
        (
            DEFAULT
            ,2
            ,email
            ,pass
            ,username
            ,name
            ,GETDATE()
            ,img_profile
            ,apellido_paterno
            ,apellido_materno
        );
    -- END IF;
END;

-- Stored Procedure Add File
CREATE PROCEDURE gallery_exp.sp_add_file(
    fk_user BIGINT
    ,name_file VARCHAR(125)
    ,url_file VARCHAR(256)
    ,sha256 VARCHAR(256)
    ,date_uploaded DATETIME
    ,extension_file VARCHAR(10)
    ,size_file VARCHAR(100)
)
BEGIN
    INSERT INTO gallery_exp.files
    VALUES
    (
        DEFAULT
        ,fk_user
        ,name_file
        ,url_file
        ,sha256
        ,date_uploaded
        ,extension_file
        ,size_file
        ,TRUE
    );

END;

--Stored Procedure Add Tag
CREATE PROCEDURE gallery_exp.sp_add_tag(
    name VARCHAR(50)
    ,description VARCHAR(100)
)
BEGIN
    DECLARE contName SMALLINT;
    SELECT COUNT(*) INTO contName FROM gallery_exp.tags WHERE name = name1;
    IF contName < 1 THEN
        INSERT INTO gallery_exp.tags
        VALUES
        (
            DEFAULT
            ,name
            ,description
            ,GETDATE()
            ,DEFAULT
            ,DEFAULT
        );
    END IF;
END;

--Stored Procedure Add Tag to File
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