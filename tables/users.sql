CREATE TABLE IF NOT EXISTS gallery_exp.users(
    id_user BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fk_status SMALLINT NOT NULL DEFAULT 2,
    email VARCHAR(125) NOT NULL UNIQUE,
    pass VARCHAR(256) NOT NULL,
    username VARCHAR(16) NOT NULL UNIQUE,
    name VARCHAR(20) NOT NULL,
    created_account DATETIME NOT NULL,
    img_profile VARCHAR(256),
    apellido_paterno VARCHAR(30),
    apellido_materno VARCHAR(30),
    FOREIGN KEY(fk_status) REFERENCES gallery_exp.status(id_status)
);