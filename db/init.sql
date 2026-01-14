-- Create the database
CREATE DATABASE stackDB;
GO

USE stackDB;
GO

CREATE TABLE dbo.appUsers(
    auPK INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(32) NOT NULL,
    age INT NOT NULL,
    city VARCHAR(32) NOT NULL,
    username VARCHAR(256) NOT NULL,
    normalized_username VARCHAR(256) NULL,
    email VARCHAR(256) NOT NULL,
    normalized_email VARCHAR(256) NULL,
    email_confirmed BIT NOT NULL DEFAULT 0,
    password NVARCHAR(MAX) NOT NULL,
    security_stamp NVARCHAR(MAX) NULL,
    concurrency_stamp NVARCHAR(MAX) NULL,
    phone_number NVARCHAR(MAX) NULL,
    phone_number_confirmed BIT NOT NULL DEFAULT 0,
    two_factor_enabled BIT NOT NULL DEFAULT 0,
    lockout_end DATETIMEOFFSET NULL,
    lockout_enabled BIT NOT NULL DEFAULT 0,
    access_failed_count INT NOT NULL DEFAULT 0,
    dateAdded DATETIME NOT NULL DEFAULT GETDATE(),
    dateVerified DATETIME NULL
);
GO

-- Identity Supporting Tables
CREATE TABLE dbo.AspNetRoles(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	Name NVARCHAR(256) NULL,
	NormalizedName NVARCHAR(256) NULL,
	ConcurrencyStamp NVARCHAR(MAX) NULL
);

CREATE TABLE dbo.AspNetRoleClaims(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	RoleId INT NOT NULL,
	ClaimType NVARCHAR(MAX) NULL,
	ClaimValue NVARCHAR(MAX) NULL,
	CONSTRAINT FK_AspNetRoleClaims_AspNetRoles_RoleId FOREIGN KEY (RoleId) REFERENCES dbo.AspNetRoles (Id) ON DELETE CASCADE
);

CREATE TABLE dbo.AspNetUserRoles(
	UserId INT NOT NULL,
	RoleId INT NOT NULL,
	PRIMARY KEY (UserId, RoleId),
	CONSTRAINT FK_AspNetUserRoles_AspNetRoles_RoleId FOREIGN KEY (RoleId) REFERENCES dbo.AspNetRoles (Id) ON DELETE CASCADE,
	CONSTRAINT FK_AspNetUserRoles_appUsers_UserId FOREIGN KEY (UserId) REFERENCES dbo.appUsers (auPK) ON DELETE CASCADE
);

CREATE TABLE dbo.AspNetUserClaims(
	Id INT IDENTITY(1,1) PRIMARY KEY,
	UserId INT NOT NULL,
	ClaimType NVARCHAR(MAX) NULL,
	ClaimValue NVARCHAR(MAX) NULL,
	CONSTRAINT FK_AspNetUserClaims_appUsers_UserId FOREIGN KEY (UserId) REFERENCES dbo.appUsers (auPK) ON DELETE CASCADE
);

CREATE TABLE dbo.AspNetUserLogins(
	LoginProvider NVARCHAR(450) NOT NULL,
	ProviderKey NVARCHAR(450) NOT NULL,
	ProviderDisplayName NVARCHAR(MAX) NULL,
	UserId INT NOT NULL,
	PRIMARY KEY (LoginProvider, ProviderKey),
	CONSTRAINT FK_AspNetUserLogins_appUsers_UserId FOREIGN KEY (UserId) REFERENCES dbo.appUsers (auPK) ON DELETE CASCADE
);

CREATE TABLE dbo.AspNetUserTokens(
	UserId INT NOT NULL,
	LoginProvider NVARCHAR(450) NOT NULL,
	Name NVARCHAR(450) NOT NULL,
	Value NVARCHAR(MAX) NULL,
	PRIMARY KEY (UserId, LoginProvider, Name),
	CONSTRAINT FK_AspNetUserTokens_appUsers_UserId FOREIGN KEY (UserId) REFERENCES dbo.appUsers (auPK) ON DELETE CASCADE
);
GO
