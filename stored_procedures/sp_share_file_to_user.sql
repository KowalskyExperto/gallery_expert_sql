DELIMITER //
CREATE PROCEDURE gallery_exp.sp_share_file_to_user(
    id_file BIGINT
    ,id_owner BIGINT
    ,email VARCHAR(150)
)
proc_share_file:BEGIN
    DECLARE contLinked SMALLINT;
    DECLARE id_user BIGINT DEFAULT 0;
    DECLARE id_shared BIGINT DEFAULT 0;
    SELECT u.id_user INTO id_user FROM gallery_exp.users AS u WHERE u.email = email;
    
    IF(SELECT COUNT(*) FROM gallery_exp.files AS f WHERE f.id_file = id_file AND f.fk_user != id_owner) = 1 THEN
        SELECT 404 AS "code" ,'ERROR: The user is not the Owner' AS "description";
        LEAVE proc_share_file;
    END IF;

    IF (SELECT COUNT(*) FROM gallery_exp.files AS f WHERE f.id_file = id_file AND f.fk_user = id_user)>0 THEN
        SELECT 404 AS "code" ,'ERROR: The user to share is the Owner' AS "description";
        LEAVE proc_share_file;
    END IF;

    IF id_user=0 THEN
        SELECT 404 AS "code" ,'ERROR: Email not found' AS "description";
        LEAVE proc_share_file;
    END IF;

    IF (SELECT COUNT(*) FROM gallery_exp.shared_user AS su
            WHERE su.fk_file = id_file AND su.fk_user = id_user) < 1 THEN
        INSERT INTO gallery_exp.shared_user VALUES (DEFAULT, id_file, id_user, DEFAULT);
    END IF;

    SELECT su.id_shared_user INTO id_shared FROM gallery_exp.shared_user AS su WHERE su.fk_file = id_file AND su.fk_user = id_user;

    SELECT 200 AS "code" , CONCAT('SUCCESS: File Shared: ',id_shared) AS "description";
END;

-- EXAMPLE:
/*
CALL gallery_exp.sp_share_file_to_user(1,'domain@.com');
*/