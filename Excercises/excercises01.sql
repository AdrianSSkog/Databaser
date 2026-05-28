-- a)
SELECT * FROM GameOfThrones

SELECT 
    Title,
    Season,
    EpisodeInSeason,
    'S' + FORMAT(Season, '00') +
    'E' + FORMAT(EpisodeInSeason, '00') AS Episodes

FROM GameOfThrones

-- b)

SELECT * INTO Users2 FROM Users

SELECT
    firstname,
    lastname,
    username as old_username,
    LOWER(SUBSTRING(FirstName, 1, 2)) + LOWER(SUBSTRING(LastName, 1, 2)) as new_username
FROM Users2

UPDATE Users2
SET UserName = LOWER(SUBSTRING(FirstName, 1, 2)) + LOWER(SUBSTRING(LastName, 1, 2))

-- c)
SELECT * INTO Airports2 FROM Airports

SELECT * FROM Airports2

UPDATE Airports2
SET DST = '-' WHERE DST IS NULL

UPDATE Airports2
SET Time = '-' WHERE Time IS NULL

SELECT * FROM Airports2

-- d)
SELECT * INTO elements2 FROM Elements

SELECT * FROM elements2

DELETE
FROM elements2 
WHERE Name IN ('Erbium', 'Helium', 'Nitrogen', 'Platinum', 'Selenium')
OR LOWER(LEFT(Name, 1)) IN ('d', 'k', 'm', 'o', 'u')

select * FROM elements2

-- e)

SELECT
    Symbol,
    Name,
    CASE 
        when LEFT(Name, LEN(Symbol)) = symbol then 'Yes'
        Else 'No' 
    END as Match
INTO elements3
FROM Elements

SELECT * FROM elements3

-- f)

SELECT Name, Red, Green, Blue INTO Colors2 FROM Colors

select 
    Name,
    '#' + CONCAT(FORMAT(Red, 'X2'), FORMAT(Green, 'X2'), FORMAT(Blue, 'X2')) as code,
    Red,
    Green,
    Blue
FROM Colors2

-- g)
DROP TABLE types2
select Integer, String into types2 from Types
select 
    Integer,
    CAST([Integer]/100.0 as float(2)) as [float],
    String,
    DATETIMEFROMPARTS(2019, 01, [Integer], 09, [Integer], 0, 0) as [DateTime],
    CASE WHEN [Integer] % 2 = 1 THEN 1 ELSE 0 END AS Bool
from types2

select * FROM Types


