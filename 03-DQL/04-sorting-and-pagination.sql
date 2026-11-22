-- ----------------------------------------------------------------------------
-- 4. ORDER BY, LIMIT AND OFFSET
-- ----------------------------------------------------------------------------

-- Cheapest to most expensive
SELECT *
FROM products
ORDER BY price ASC;

-- Most expensive to cheapest
SELECT *
FROM products
ORDER BY price DESC;

-- Sort by category, then by price within each category
SELECT *
FROM products
ORDER BY category_id ASC, price ASC;

-- Top 5 most expensive products
SELECT *
FROM products
ORDER BY price DESC
LIMIT 5;

-- Pagination: page size = 5
SELECT *
FROM products
ORDER BY product_id
LIMIT 5 OFFSET 0;  -- Page 1

SELECT *
FROM products
ORDER BY product_id
LIMIT 5 OFFSET 5;  -- Page 2

-- Formula: OFFSET = (page_number - 1) * page_size
-- Example: page 3, page size 5 => OFFSET = (3 - 1) * 5 = 10
