CREATE DATABASE gallery_exp CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

USE gallery_exp;

CREATE TABLE IF NOT EXISTS gallery_exp.status(
    id_status SMALLINT NOT NULL PRIMARY KEY,
    status VARCHAR(10) NOT NULL
);

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

CREATE TABLE IF NOT EXISTS gallery_exp.tags(
    id_tag BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(100),
    created_at DATETIME NOT NULL,
    count BIGINT DEFAULT 0,
    status BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS gallery_exp.files(
    id_file BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fk_user BIGINT NOT NULL,
    name_file VARCHAR(125) NOT NULl,
    url_file VARCHAR(256) NOT NULL,
    sha256 VARCHAR(256) NOT NULL,
    date_uploaded DATETIME NOT NULL,
    extension_file VARCHAR(10) NOT NULL,
    size_file VARCHAR(100) NOT NULL,
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY(fk_user) REFERENCES gallery_exp.users(id_user)
);

CREATE TABLE IF NOT EXISTS gallery_exp.shared_user(
    id_shared_user BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fk_file BIGINT NOT NULL,
    fk_user BIGINT NOT NULL,
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY(fk_file) REFERENCES gallery_exp.files(id_file),
    FOREIGN KEY(fk_user) REFERENCES gallery_exp.users(id_user)
);

CREATE TABLE IF NOT EXISTS gallery_exp.file_tag(
    id_file_tag BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fk_file BIGINT NOT NULL,
    fk_tag BIGINT NOT NULL,
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY(fk_file) REFERENCES gallery_exp.files(id_file),
    FOREIGN KEY(fk_tag) REFERENCES gallery_exp.tags(id_tag)
);