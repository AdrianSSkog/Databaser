-- a)

SELECT 
    [Period],
    MIN([Number]) as [from],
    MAX([Number]) as [to],
    CAST(AVG([Stableisotopes]) AS DECIMAL(10, 2)) as [average isotope],
    STRING_AGG(Symbol, ', ') as [symbols]
FROM Elements
GROUP BY [Period]
ORDER BY [Period]

-- b)

SELECT 
    City,
    Region,
    Country,
    COUNT(*) as Customers
FROM
    company.customers
GROUP BY
    City,
    Region,
    Country
HAVING
    COUNT(*) >= 2

-- c)

DECLARE @message VARCHAR(MAX);
SET @message = ''

SELECT 
    @message = @message + ' Säsong ' + CAST([Season] as VARCHAR) + ' sändes från ' + 
    FORMAT(MIN([Original air date]), 'MMMM', 'sv-SE') + ' till ' +
    FORMAT(MAX([Original air date]), 'MMMM', 'sv-SE') + ' ' + FORMAT(MIN([Original air date]), 'yyyy') +
    '. Totalt sändes ' + CAST(COUNT(*) as VARCHAR) + ' avsnitt, som sågs av ' + 
    CAST(SUM([U.S. viewers(millions)]) as VARCHAR) + ' miljoner människor i USA.' +
    CHAR(13) + CHAR(10)
FROM 
    GameOfThrones
GROUP BY
    Season
ORDER BY
    Season;

PRINT @message;

-- d)

SELECT 
    CONCAT(FirstName, ' ', LastName) as [Name],
    DATEDIFF(year, CONVERT(date, LEFT(ID, 6)), GETDATE()) AS Ålder,
    CASE WHEN LEFT(RIGHT(ID, 2), 1) % 2 = 1 THEN 'Kvinna' ELSE 'Man' END AS Kön
FROM Users
ORDER BY [Name]

-- e)

SELECT 
    Region,
    SUM(CAST([Population] as bigint)) as [population],
    COUNT(Country) as countries,
    SUM(CAST([Area (sq# mi#)] as bigint)) as Area,
    CAST(SUM(CAST([Population] as float)) / SUM(CAST([Area (sq# mi#)] as float)) as decimal(10, 2)) as [Pop density],
    ROUND(AVG(CAST(REPLACE([Infant mortality (per 1000 births)], ',', '.') as float)*100), 0) as [Infant mortality per 100000 births]
FROM Countries
GROUP BY Region

-- f)

SELECT 
    CASE WHEN CHARINDEX(',', [Location served]) > 0 THEN 
        SUBSTRING([Location served], LEN([Location served]) - CHARINDEX(',', REVERSE([Location served])) + 2, CHARINDEX(',', REVERSE([Location served])) - 1) 
        ELSE [Location served] END AS Country,
    count(IATA) AS [number of airports],
    SUM(CASE WHEN ICAO IS NULL THEN 1 ELSE 0 END) AS [Missing ICAO],
    FORMAT(CAST(SUM(CASE WHEN ICAO IS NULL THEN 1 ELSE 0 END) as float) / CAST(count(IATA) as float), 'P2') AS [Missing ICAO Percent]
FROM Airports
GROUP BY CASE WHEN CHARINDEX(',', [Location served]) > 0 THEN 
        SUBSTRING([Location served], LEN([Location served]) - CHARINDEX(',', REVERSE([Location served])) + 2, CHARINDEX(',', REVERSE([Location served])) - 1) 
        ELSE [Location served] END
