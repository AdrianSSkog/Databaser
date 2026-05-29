USE everyloop;
GO

SELECT * FROM company.products;
GO

SELECT * FROM company.orders
GO

SELECT * FROM company.order_details

SELECT 
    co.ShipCity,
    COUNT(DISTINCT cod.ProductId) AS Products
FROM company.products cp 
JOIN company.order_details cod ON cp.Id = cod.ProductId
JOIN company.orders co ON cod.OrderId = co.Id
WHERE ShipCity = 'London'
GROUP BY co.ShipCity
GO

SELECT COUNT(DISTINCT ProductId) FROM company.order_details

SELECT
    s.Name AS Student,
    c.Name AS Course,
    sg.grade AS Grade
FROM Students s 
JOIN StudentGrade sg ON s.StudentID = sg.StudentID
JOIN Course c ON sg.CourseID = c.CourseID;



