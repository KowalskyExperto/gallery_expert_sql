CREATE TABLE IF NOT EXISTS gallery_exp.shared_user(
    id_shared_user BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fk_file BIGINT NOT NULL,
    fk_user BIGINT NOT NULL,
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY(fk_file) REFERENCES gallery_exp.files(id_file),
    FOREIGN KEY(fk_user) REFERENCES gallery_exp.users(id_user)
);