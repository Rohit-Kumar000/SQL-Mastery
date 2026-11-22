/*
===============================================================================
SQL MASTERY | 03 - DQL (Data Query Language)
Database: PostgreSQL
===============================================================================
*/


-- ----------------------------------------------------------------------------
-- 1. SELECT BASICS
-- ----------------------------------------------------------------------------

-- View all products
SELECT * FROM products;

-- Select specific columns and use aliases
SELECT
    product_id,
    product_name AS "Product Name",
    price,
    stock_quantity
FROM products;

-- View all customers
SELECT * FROM customers;

-- DISTINCT: list each city only once
SELECT DISTINCT city
FROM customers
WHERE city IS NOT NULL;
