-- Demodata

USE BookStore;
GO

INSERT INTO 
    Authors (FirstName, LastName, BirthDate, DeathDate)
VALUES
    ('Robert Louis', 'Stevenson', '1850-11-13', '1894-12-03'),
    ('Marcus', 'Aurelius', '0121-04-26', '0180-03-17'),
    ('George', 'Orwell', '1903-06-25', '1950-01-21'),
    ('Yuval Noah', 'Harari', '1976-02-24', NULL),
    ('Karl', 'Marx', '1818-05-05', '1883-03-14'),
    ('Friedrich', 'Engels', '1820-11-28', '1895-08-05'),
    ('Friedrich', 'Nietzsche', '1844-10-15', '1900-08-25'),
    ('Stephen', 'King', '1947-09-21', NULL),
    ('Peter', 'Straub', '1943-03-02', '2022-09-04'),
    ('Harry', 'Martinson', '1904-05-06', '1978-02-11');
GO

INSERT INTO 
    Publishers ([Name], [Location])
VALUES 
    ('B. Wahlström', 'Stockholm'),
    ('Penguin Books', 'London'),
    ('Harvill Secker', 'London'),
    ('Natur & Kultur', 'Stockholm'),
    ('Albert Bonniers Förlag', 'Stockholm'),
    ('Vintage Books', 'New York'),
    ('Scribner', 'New York');
GO


INSERT INTO 
    Books (ISBN, Title, Genre, Publisher_Id, [Language], Price, Published_Date
)
VALUES
    ('9789132153716', 'Skattkammarön', 'Adventure', 1, 'Swedish', 129.00, '1883-11-14'),
    ('9780140449334', 'Meditations', 'Philosophy', 2, 'English', 149.00, '0180-01-01'),
    ('9780451526342', 'Animal Farm', 'Political Satire', 2, 'English', 119.00, '1945-08-17'),
    ('9780451524935', '1984', 'Dystopian', 2, 'English', 139.00, '1949-06-08'),
    ('9780062316097', 'Sapiens', 'History', 3, 'English', 199.00, '2011-01-01'),
    ('9781911709881', 'Nexus', 'Technology', 3, 'English', 229.00, '2024-01-01'),
    ('9780140445688', 'Das Kapital', 'Economics', 2, 'German', 179.00, '1867-09-14'),
    ('9780140447576', 'The Communist Manifesto', 'Politics', 2, 'English', 99.00, '1848-02-21'),
    ('9789177425763', 'Så talade Zarathustra', 'Philosophy', 4, 'Swedish', 159.00, '1883-01-01'),
    ('9780670691997', 'The Talisman', 'Horror', 6, 'English', 189.00, '1984-11-08'),
    ('9789100477677', 'Aniara', 'Science Fiction', 5, 'Swedish', 149.00, '1956-10-13'),
    ('9781982110567', 'The Institute', 'Horror', 7, 'English', 219.00, '2019-09-10'),
    ('9780307743664', 'Carrie', 'Horror', 6, 'English', 129.00, '1974-04-05');
GO

INSERT INTO 
    BookAuthors (ISBN, Author_Id)
VALUES
    ('9789132153716', 1),
    ('9780140449334', 2),
    ('9780451526342', 3),
    ('9780451524935', 3),
    ('9780062316097', 4),
    ('9781911709881', 4),
    ('9780140445688', 5),
    ('9780140447576', 5),
    ('9780140447576', 6),
    ('9789177425763', 7),
    ('9780670691997', 8),
    ('9780670691997', 9),
    ('9789100477677', 10),
    ('9781982110567', 8),
    ('9780307743664', 8);
GO

INSERT INTO Stores ([Name], [Address], ZipCode, City)
VALUES
    ('Bookhouse Svea', 'Sveavägen 4', '11350', 'Stockholm'),
    ('Bookhouse Avenyn', 'Kungsportsavenyn 6', '41136', 'Göteborg'),
    ('Bookhouse Paris', '18 Rue De lArc De Triomphe', '75017', 'Paris');
GO

INSERT INTO 
    StockBalance (Store_ID, ISBN, InStock)
VALUES
    (1, '9789132153716', 0),
    (1, '9780140449334', 1),
    (1, '9780451526342', 7),
    (1, '9780451524935', 8),
    (1, '9780062316097', 5),
    (1, '9781911709881', 2),
    (1, '9780140445688', 8),
    (1, '9780140447576', 6),
    (1, '9789177425763', 1),
    (1, '9780670691997', 6),
    (1, '9789100477677', 6),
    (1, '9781982110567', 4),
    (1, '9780307743664', 1),
    (2, '9789132153716', 6),
    (2, '9780140449334', 7),
    (2, '9780451526342', 2),
    (2, '9780451524935', 2),
    (2, '9780062316097', 2),
    (2, '9781911709881', 8),
    (2, '9780140445688', 5),
    (2, '9780140447576', 8),
    (2, '9789177425763', 4),
    (2, '9780670691997', 0),
    (2, '9789100477677', 10),
    (2, '9781982110567', 0),
    (2, '9780307743664', 4),
    (3, '9789132153716', 7),
    (3, '9780140449334', 5),
    (3, '9780451526342', 10),
    (3, '9780451524935', 7),
    (3, '9780062316097', 8),
    (3, '9781911709881', 4),
    (3, '9780140445688', 3),
    (3, '9780140447576', 5),
    (3, '9789177425763', 3),
    (3, '9780670691997', 1),
    (3, '9789100477677', 7),
    (3, '9781982110567', 0),
    (3, '9780307743664', 8);
GO

INSERT INTO Customers (firstname, lastname, email, phone, City, Country)
VALUES
    ('Carl', 'Svensson', 'carl.svensson@gmail.com', '0707066476', 'Stockholm', 'Sweden'),
    ('Philip', 'Svan', 'philip.svan@yahoo.com', '0712391894', 'Stockholm', 'Sweden'),
    ('Johan', 'Renault', 'johan.renault@hotmail.com', '0735038810', 'Paris', 'France'),
    ('Jeane', 'Dufour', 'jeane.dufour@outlook.com', '0720925990', 'Paris', 'France'),
    ('Bengt', 'Afzelius', 'bengt.afzelius@outlook.com', '0704254675', 'Göteborg', 'Sweden'),
    ('Kurt', 'Dufva', 'kurt.dufva@hotmail.com', '0721810780', 'Göteborg', 'Sweden'),
    ('Harald', 'Garcia', 'harald.garcia@yahoo.com', '0729596104', 'Västerås', 'Sweden'),
    ('Britta', 'Karlsson', 'britta.karlsson@outlook.com', '0733620152', 'Borås', 'Sweden'),
    ('Anna', 'Svärd', 'anna.svärd@yahoo.com', '0775432062', 'Stockholm', 'Sweden'),
    ('Sofia', 'Aubert', 'sofia.aubert@outlook.com', '0748959063', 'Kungsbacka', 'Sweden'),
    ('Felicia', 'Måndotter', 'felicia.måndotter@hotmail.com', '0789007470', 'Stockholm', 'Sweden'),
    ('Carolina', 'Andersson', 'carolina.andersson@hotmail.com', '0704584714', 'Eskilstuna', 'Sweden'),
    ('Hilda', 'Bernard', 'hilda.bernard@yahoo.com', '0793591397', 'Paris', 'France');
GO

INSERT INTO Orders (Customer_Id, Store_Id, OrderDate)
VALUES
    (1, 1, '2026-05-20'),
    (2, 1, '2026-05-21'),
    (3, 3, '2026-05-22'),
    (4, 3, '2026-05-22'),
    (5, 2, '2026-05-23'),
    (6, 2, '2026-05-24'),
    (1, 1, '2026-05-25'),
    (1, 1, '2026-05-26'),
    (2, 1, '2026-05-27'),
    (3, 3, '2026-05-27'),
    (3, 3, '2026-05-28'),
    (4, 2, '2026-05-28'),
    (5, 2, '2026-05-28');
GO

INSERT INTO OrderDetails (Order_Id, ISBN, UnitPrice, Quantity)
VALUES
    (1, '9789132153716', 129.00, 1),
    (1, '9789100477677', 149.00, 1),
    (2, '9780140449334', 149.00, 1),
    (2, '9780451526342', 119.00, 2),
    (3, '9781982110567', 219.00, 1),
    (3, '9780307743664', 129.00, 1),
    (4, '9780140445688', 179.00, 1),
    (4, '9780140447576', 99.00, 1),
    (5, '9781911709881', 229.00, 1),
    (6, '9780140449334', 149.00, 2),
    (7, '9780451526342', 119.00, 3),
    (7, '9780140449334', 149.00, 1),
    (8, '9780062316097', 199.00, 2),
    (9, '9781982110567', 219.00, 1),
    (10, '9780307743664', 129.00, 4),
    (11, '9780140447576', 99.00, 2),
    (12, '9789132153716', 129.00, 1);
GO

INSERT INTO Employees (firstname, lastname, jobtitle, Store_Id)
VALUES
    ('Lisa', 'Fröjd', 'Manager', 1),
    ('Olof', 'Blom', 'Staff', 1),
    ('Sofie', 'Jönsson', 'Staff', 1),
    ('Conrad', 'Petersson', 'Manager', 2),
    ('Linda', 'Gröning', 'Staff', 2),
    ('Edith', 'Verne', 'Manager', 3),
    ('Jules', 'Brelle', 'Staff', 3),
    ('Jeaque', 'Besson', 'Staff', 3);

