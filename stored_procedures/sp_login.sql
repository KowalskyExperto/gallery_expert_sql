DELIMITER //
CREATE PROCEDURE gallery_exp.sp_login(
    email VARCHAR(150)
    ,pass VARCHAR(35)
)
proc:BEGIN
   	DECLARE loginFailed BOOL DEFAULT FALSE;

	IF (SELECT COUNT(*) FROM gallery_exp.users AS U WHERE u.email = email AND u.pass = pass) = 0 THEN
        SELECT 400 AS "code" ,'ERROR: Login Error' AS "description";
        LEAVE proc;
	END IF;

    SELECT 200 AS "code" ,'SUCCESS: Valid Login' AS "description";
END;

-- EXAMPLE:
/*
CALL gallery_exp.sp_login('mail@.com','pass');
*/