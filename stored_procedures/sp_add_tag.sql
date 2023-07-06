CREATE OR REPLACE PROCEDURE "gallery_exp"."sp_add_tag"(
    name1 VARCHAR(50)
    ,description VARCHAR(100)
)
AS $$
DECLARE contName SMALLINT:=0;
BEGIN
    SELECT COUNT(*) INTO contName FROM "gallery_exp"."tags" WHERE "name" = name1;
    IF contName < 1 THEN
        INSERT INTO "gallery_exp"."tags"
        VALUES
        (
            DEFAULT
            ,name1
            ,description
            ,GETDATE()
            ,DEFAULT
            ,DEFAULT
        );
    END IF;
END; $$ LANGUAGE plpgsql;

--EXAMPLE:
/*
CALL "gallery_exp"."sp_add_tag"(
    'bonito'
    ,'Cosas bonitas XD'
);
*/