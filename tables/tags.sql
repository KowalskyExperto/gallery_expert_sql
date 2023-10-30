CREATE TABLE [app].[tags](
    [id_tag] BIGINT NOT NULL PRIMARY KEY IDENTITY(1,1),
    [name] VARCHAR(50) NOT NULL,
    [description] VARCHAR(100),
    [created_at] DATETIME NOT NULL,
    [count] BIGINT DEFAULT 0,
    [status] BIT DEFAULT 1
);