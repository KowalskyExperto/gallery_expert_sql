CREATE DATABASE [gallery_exp];
GO
USE [gallery_exp];
GO
CREATE SCHEMA [app];
GO
CREATE TABLE [app].[status](
    [id_status] SMALLINT NOT NULL PRIMARY KEY,
    [status] VARCHAR(10) NOT NULL
);

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

CREATE TABLE [app].[tags](
    [id_tag] BIGINT NOT NULL PRIMARY KEY IDENTITY(1,1),
    [name] VARCHAR(50) NOT NULL,
    [description] VARCHAR(100),
    [created_at] DATETIME NOT NULL,
    [count] BIGINT DEFAULT 0,
    [status] BIT DEFAULT 1
);

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

CREATE TABLE [app].[shared_user](
    [id_shared_user] BIGINT NOT NULL PRIMARY KEY IDENTITY(1,1),
    [fk_file] BIGINT NOT NULL,
    [fk_user] BIGINT NOT NULL,
    [status] SMALLINT DEFAULT 1,
    FOREIGN KEY([fk_file]) REFERENCES [app].[files]([id_file]),
    FOREIGN KEY([fk_user]) REFERENCES [app].[users]([id_user])
);

CREATE TABLE [app].[file_tag](
    [id_file_tag] BIGINT NOT NULL PRIMARY KEY IDENTITY(1,1),
    [fk_file] BIGINT NOT NULL,
    [fk_tag] BIGINT NOT NULL,
    [status] BIT DEFAULT 1,
    FOREIGN KEY([fk_file]) REFERENCES [app].[files]([id_file]),
    FOREIGN KEY([fk_tag]) REFERENCES [app].[tags]([id_tag])
);