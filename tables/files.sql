CREATE TABLE [app].[files](
    [id_file] BIGINT NOT NULL PRIMARY KEY IDENTITY(1,1),
    [fk_user] BIGINT NOT NULL,
    [name_file] VARCHAR(125) NOT NULL,
    [url_file] VARCHAR(256) NOT NULL,
    [sha256] VARCHAR(256) NOT NULL,
    [date_uploaded] DATETIME NOT NULL,
    [extension_file] VARCHAR(10) NOT NULL,
    [size_file] VARCHAR(100) NOT NULL,
    [status] BIT DEFAULT 1,
    FOREIGN KEY([fk_user]) REFERENCES [app].[users]([id_user])
);