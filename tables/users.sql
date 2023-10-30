CREATE TABLE [app].[users](
    [id_user] BIGINT NOT NULL PRIMARY KEY IDENTITY(1,1),
    [fk_status] SMALLINT NOT NULL DEFAULT 2,
    [email] VARCHAR(125) NOT NULL UNIQUE,
    [pass] VARCHAR(256) NOT NULL,
    [username] VARCHAR(16) NOT NULL UNIQUE,
    [name] VARCHAR(20) NOT NULL,
    [created_account] DATETIME NOT NULL DEFAULT GETDATE(),
    [img_profile] VARCHAR(256),
    [apellido_paterno] VARCHAR(30),
    [apellido_materno] VARCHAR(30),
    FOREIGN KEY([fk_status]) REFERENCES [app].[status]([id_status])
);