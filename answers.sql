--Question1

DROP DATABASE IF EXISTS;
CREATE DATABASE mysqlTest;
USE mysqlTest;


  CREATE TABLE ProductDetail (
    OrderID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(255)
);


INSERT INTO ProductDetail (OrderID, CustomerName, Products)
VALUES 
(1, 'Alice', 'Apples, Oranges'),
(2, 'Bob', 'Bananas, Mangoes, Kiwi'),
(3, 'Charlie', 'Pineapple, Grapes');


-- Normalize ProductDetail in MySQL using recursive CTE
WITH RECURSIVE SplitProducts AS (
    SELECT 
        OrderID,
        CustomerName,
        SUBSTRING_INDEX(Products, ',', 1) AS Product,
        SUBSTRING(Products, LENGTH(SUBSTRING_INDEX(Products, ',', 1)) + 2) AS Rest
    FROM ProductDetail

    UNION ALL

    SELECT
        OrderID,
        CustomerName,
        SUBSTRING_INDEX(Rest, ',', 1),
        SUBSTRING(Rest, LENGTH(SUBSTRING_INDEX(Rest, ',', 1)) + 2)
    FROM SplitProducts
    WHERE Rest != ''
)
SELECT 
    OrderID, 
    CustomerName, 
    TRIM(Product) AS Product
FROM SplitProducts;




--Question2
USE mysqlTest;

CREATE TABLE OrderDetails (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT
);


INSERT INTO OrderDetails (OrderID, CustomerName, Product, Quantity)
VALUES
(101, 'John Doe', 'Laptop', 2),
(101, 'John Doe', 'Mouse', 1),
(102, 'Jane Smith', 'Tablet', 3),
(102, 'Jane Smith', 'Keyboard', 1),
(102, 'Jane Smith', 'Mouse', 2),
(103, 'Emily Clark', 'Phone', 1);


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;


INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

SELECT * FROM Orders;
SELECT * FROM OrderItems;



