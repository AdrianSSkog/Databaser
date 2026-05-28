USE BookStore;
GO
-- Titles per author view

CREATE VIEW TitlesPerAuthor AS
SELECT
    CONCAT(a.FirstName, ' ', a.LastName) AS [Name],
    CASE WHEN a.DeathDate IS NULL
    THEN CASE WHEN DATEADD(year, DATEDIFF(year, a.BirthDate, GETDATE()), a.BirthDate) > GETDATE()
        THEN DATEDIFF(year, a.BirthDate, GETDATE()) - 1
        ELSE DATEDIFF(year, a.BirthDate, GETDATE())
        END
    ELSE CASE WHEN DATEADD(year, DATEDIFF(year, a.BirthDate, a.DeathDate), a.BirthDate) > a.DeathDate
        THEN DATEDIFF(year, a.BirthDate, a.DeathDate) - 1
        ELSE DATEDIFF(year, a.BirthDate, a.DeathDate)
        END
    END AS Age,
    COUNT(DISTINCT ba.ISBN) AS Titles,
    SUM(sb.stockTotal * b.Price) AS StockValue
FROM Authors a
JOIN BookAuthors ba ON a.Author_ID = ba.Author_Id
JOIN Books b ON ba.ISBN = b.ISBN
JOIN (
    SELECT ISBN, SUM(InStock) as stockTotal
    FROM StockBalance
    GROUP BY ISBN
    ) sb ON b.ISBN = sb.ISBN
GROUP BY a.Author_ID, a.FirstName, a.LastName, a.BirthDate, a.DeathDate;
GO


-- Top customers
-- This view is usefull to identify valuable customers, analyse their spending behavior
-- and see geographically where the most loyal customers are located.

CREATE VIEW TopCustomers AS
SELECT 
    CONCAT(c.firstname, ' ', c.lastname) AS [Name],
    c.City AS City,
    COUNT(DISTINCT o.Order_Id) AS Number_of_Orders,
    SUM(ot.order_total) AS TotalSpending,
    CAST(AVG(ot.order_total) AS decimal(10, 2)) AS AverageSpendingPerOrder,
    MAX(ot.order_total) AS LargestOrder,
    MAX(o.OrderDate) AS LastOrder
FROM Customers c
JOIN Orders o ON o.Customer_Id = c.Customer_Id
JOIN (
        SELECT 
            Order_Id, 
            SUM(UnitPrice * quantity) AS order_total 
        FROM OrderDetails
        GROUP BY Order_Id
    ) ot ON ot.Order_Id = o.Order_Id
GROUP BY c.Customer_Id, c.firstname, c.lastname, c.City;
GO

SELECT * FROM TopCustomers
ORDER BY TotalSpending DESC;
GO
