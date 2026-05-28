-- Create bookstore database

CREATE DATABASE BookStore;

GO

USE BookStore;

GO

CREATE TABLE Authors (
    Author_ID Int IDENTITY(1, 1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    BirthDate DATE,
    DeathDate DATE NULL
);
GO

CREATE TABLE Publishers (
    Publisher_Id Int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
    [Name] VARCHAR(50) NOT NULL,
    [Location] VARCHAR(30) NOT NULL
);
GO

CREATE TABLE Books (
    ISBN CHAR(13) NOT NULL PRIMARY KEY,
    CHECK (LEN(ISBN) = 13 AND ISBN NOT like '%[^0-9]%'),
    Title VARCHAR(50) NOT NULL,
    Genre VARCHAR(50),
    Publisher_Id Int NOT NULL,
    [Language] VARCHAR(30) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL CHECK (Price >= 0),
    Published_Date DATE,
    FOREIGN KEY (Publisher_Id) REFERENCES Publishers(Publisher_Id)
);
GO

CREATE TABLE BookAuthors (
    ISBN CHAR(13) NOT NULL,
    Author_Id Int NOT NULL,
    PRIMARY KEY (ISBN, Author_Id),
    FOREIGN KEY (ISBN) REFERENCES Books(ISBN),
    FOREIGN KEY (Author_Id) REFERENCES Authors(Author_ID)
);
GO

CREATE TABLE Stores (
    Store_ID Int IDENTITY(1, 1) PRIMARY KEY,
    [Name] VARCHAR(50) NOT NULL,
    [Address] VARCHAR(50) NOT NULL,
    ZipCode VARCHAR(10) NOT NULL,
    City VARCHAR(30) NOT NULL
);
GO

CREATE TABLE StockBalance (
    Store_ID Int NOT NULL,
    ISBN CHAR(13) NOT NULL,
    InStock Int NOT NULL CHECK (InStock >= 0),
    PRIMARY KEY (Store_ID, ISBN),
    FOREIGN KEY (Store_ID) REFERENCES Stores(Store_ID),
    FOREIGN KEY (ISBN) REFERENCES Books(ISBN)
);
GO

CREATE TABLE Customers (
    Customer_Id Int IDENTITY(1, 1) PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    phone VARCHAR(20),
    City VARCHAR(30) NOT NULL,
    Country VARCHAR(30) NOT NULL
);
GO

CREATE TABLE Orders (
    Order_Id Int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
    Customer_Id Int NOT NULL,
    Store_Id Int NOT NULL,
    OrderDate DATE NOT NULL,
    FOREIGN KEY (Customer_Id) REFERENCES Customers(Customer_Id),
    FOREIGN KEY (Store_Id) REFERENCES Stores(Store_ID)
);
GO

CREATE TABLE OrderDetails (
    Order_Id Int NOT NULL,
    ISBN CHAR(13) NOT NULL,
    PRIMARY KEY (Order_Id, ISBN),
    UnitPrice DECIMAL(10, 2) NOT NULL CHECK (UnitPrice >= 0),
    Quantity Int NOT NULL CHECK (Quantity > 0),
    FOREIGN KEY (Order_Id) REFERENCES Orders(Order_Id),
    FOREIGN KEY (ISBN) REFERENCES Books(ISBN)
);
GO

