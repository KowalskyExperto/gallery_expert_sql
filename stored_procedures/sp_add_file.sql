DELIMITER //
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

-- EXAMPLE
/*
CALL gallery_exp.sp_add_file(
    1
    ,'archivo.png'
    ,'www.algo.com/files/images/img/asiuOijuslkj123.png'
    ,'JHKJAKMNCNLKJQKJL2398A'
    ,1688598991
    ,'png'
    ,'1271312'
)
*/