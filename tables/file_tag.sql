CREATE TABLE IF NOT EXISTS gallery_exp.file_tag(
    id_file_tag BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fk_file BIGINT NOT NULL,
    fk_tag BIGINT NOT NULL,
    status BOOLEAN DEFAULT TRUE,
    FOREIGN KEY(fk_file) REFERENCES gallery_exp.files(id_file),
    FOREIGN KEY(fk_tag) REFERENCES gallery_exp.tags(id_tag)
);