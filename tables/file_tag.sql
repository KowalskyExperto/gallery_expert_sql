CREATE TABLE [app].[file_tag](
    [id_file_tag] BIGINT NOT NULL PRIMARY KEY IDENTITY(1,1),
    [fk_file] BIGINT NOT NULL,
    [fk_tag] BIGINT NOT NULL,
    [status] BIT DEFAULT 1,
    FOREIGN KEY([fk_file]) REFERENCES [app].[files]([id_file]),
    FOREIGN KEY([fk_tag]) REFERENCES [app].[tags]([id_tag])
);