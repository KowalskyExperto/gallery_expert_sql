CREATE TABLE [app].[shared_user](
    [id_shared_user] BIGINT NOT NULL PRIMARY KEY IDENTITY(1,1),
    [fk_file] BIGINT NOT NULL,
    [fk_user] BIGINT NOT NULL,
    [status] SMALLINT DEFAULT 1,
    FOREIGN KEY([fk_file]) REFERENCES [app].[files]([id_file]),
    FOREIGN KEY([fk_user]) REFERENCES [app].[users]([id_user])
);