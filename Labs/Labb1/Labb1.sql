-- Moon missions

DROP TABLE IF EXISTS SuccessfulMissions;

SELECT 
    Spacecraft, 
    [Launch date], 
    [Carrier rocket], 
    Operator, 
    [Mission type] 
INTO SuccessfulMissions 
FROM MoonMissions
WHERE Outcome IN ('Success', 'Successful');

GO

UPDATE SuccessfulMissions
SET Operator = LTRIM(RTRIM(Operator));

GO

UPDATE SuccessfulMissions
SET Spacecraft = CASE WHEN CHARINDEX('(', Spacecraft) > 0
    THEN RTRIM(LEFT(Spacecraft, CHARINDEX('(', Spacecraft) - 1))
    ELSE Spacecraft
    END;

GO

SELECT 
    Operator,
    [Mission type],
    COUNT(*) AS [Mission count]
FROM 
    SuccessfulMissions
GROUP BY
    Operator,
    [Mission type]
HAVING
    COUNT(*) > 1;

GO

-- Users

DROP TABLE IF EXISTS NewUsers;

SELECT 
    *,
    FirstName + ' ' + LastName AS [Name],
    CASE WHEN LEFT(RIGHT(ID, 2), 1) % 2 = 1 THEN 'Male' ELSE 'Female' END AS Gender
INTO NewUsers
FROM Users;

GO

SELECT 
    UserName,
    COUNT(*) AS Count
FROM NewUsers
GROUP BY
    UserName
HAVING
    COUNT(*) > 1; 

GO 

WITH [numbered users] AS (
    SELECT 
        ID,
        UserName,
        FirstName,
        LastName,
        ROW_NUMBER() OVER (PARTITION BY UserName ORDER BY ID) AS Indx
    FROM NewUsers
)
UPDATE [numbered users]
SET UserName = CASE 
    WHEN Indx > 1 AND Indx < 10
    THEN CONCAT(LEFT(FirstName, 3), LEFT(LastName, 2), CAST(Indx - 1 AS VARCHAR(1)))
    WHEN Indx >= 10
    THEN CONCAT(LEFT(FirstName, 2), LEFT(LastName, 2), CAST(Indx - 1 AS VARCHAR(2)))
    ELSE UserName
    END;

GO

DELETE FROM NewUsers WHERE CAST(LEFT(ID, 2) AS INT) < 70 AND Gender = 'Female';

GO

INSERT INTO NewUsers (
    ID,
    UserName,
    [Password],
    FirstName,
    LastName,
    Email,
    Phone,
    [Name],
    Gender
)
VALUES (
    '340609-1237',
    'carank',
    LOWER(CONVERT(VARCHAR(32), HASHBYTES('MD5', 'Lösen321'), 2)),
    'Carl',
    'Anka',
    'carl.anka@gmail.com',
    '0707-654321',
    'Carl Anka',
    'Male'
);

GO

SELECT 
    Gender,
    AVG(CASE WHEN CAST(LEFT(ID, 2) AS int) > 25
        THEN
            CASE WHEN DATEADD(year, DATEDIFF(year, '19' + LEFT(ID, 6), GETDATE()), '19' + LEFT(ID, 6)) > GETDATE()
            THEN DATEDIFF(year, '19' + LEFT(ID, 6), GETDATE()) - 1
            ELSE DATEDIFF(year, '19' + LEFT(ID, 6), GETDATE())
            END 
        ELSE
            CASE WHEN DATEADD(year, DATEDIFF(year, '20' + LEFT(ID, 6), GETDATE()), '20' + LEFT(ID, 6)) > GETDATE()
            THEN DATEDIFF(year, '20' + LEFT(ID, 6), GETDATE()) - 1
            ELSE DATEDIFF(year, '20' + LEFT(ID, 6), GETDATE())
            END 
        END
        ) AS [Average age]
FROM NewUsers
GROUP BY Gender;

GO

-- Company

SELECT 
    products.ID AS ID,
    products.ProductName AS Product,
    suppliers.CompanyName AS Supplier,
    categories.CategoryName AS Category
FROM 
    company.products 
JOIN company.suppliers ON products.SupplierId = suppliers.ID
JOIN company.categories ON products.CategoryId = categories.ID;

GO

SELECT 
    regions.Id AS regionID,
    regions.RegionDescription AS region,
    COUNT(DISTINCT employee_territory.EmployeeId) AS employees 
FROM company.employee_territory
JOIN company.territories ON employee_territory.TerritoryId = territories.Id
JOIN company.regions ON regions.Id = territories.RegionId
GROUP BY regions.Id, regions.RegionDescription;
    
GO

SELECT 
    a.Id as Id,
    CONCAT(a.TitleOfCourtesy, ' ', a.FirstName, ' ', a.LastName) AS [Name],
    CASE WHEN a.ReportsTo IS NULL
    THEN 'Nobody!'
    ELSE CONCAT(b.TitleOfCourtesy, ' ', b.FirstName, ' ', b.LastName) 
    END AS [Reports to]
FROM company.employees AS a 
LEFT JOIN company.employees AS b ON a.ReportsTo = b.Id;



