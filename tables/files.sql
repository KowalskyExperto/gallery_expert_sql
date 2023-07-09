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