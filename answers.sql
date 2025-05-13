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
