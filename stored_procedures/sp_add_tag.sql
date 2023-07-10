DELIMITER //
CREATE PROCEDURE gallery_exp.sp_add_tag(
    name VARCHAR(50)
    ,description VARCHAR(100)
)
BEGIN
    DECLARE contName SMALLINT;
    SELECT COUNT(*) INTO contName FROM gallery_exp.tags AS t WHERE t.name = name;
    IF contName < 1 THEN
        INSERT INTO gallery_exp.tags
        VALUES
        (
            DEFAULT
            ,name
            ,description
            ,NOW()
            ,DEFAULT
            ,DEFAULT
        );
    END IF;
END;

--EXAMPLE:
/*
CALL gallery_exp.sp_add_tag(
    'bonito'
    ,'Cosas bonitas XD'
);
*/