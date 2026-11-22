-- ----------------------------------------------------------------------------
-- 2. WHERE AND COMPARISON OPERATORS
-- ----------------------------------------------------------------------------

-- Products priced above Rs. 3,000
SELECT *
FROM products
WHERE price > 3000;

-- Products in stock and priced below Rs. 1,500
SELECT *
FROM products
WHERE stock_quantity > 0
  AND price < 1500;

-- Products that are out of stock OR priced below Rs. 500
SELECT *
FROM products
WHERE stock_quantity = 0
   OR price < 500;

-- Products that are inactive
SELECT *
FROM products
WHERE NOT is_active;

-- Products priced between Rs. 1,000 and Rs. 3,000 (inclusive)
SELECT *
FROM products
WHERE price BETWEEN 1000 AND 3000;

-- Products from selected categories
SELECT *
FROM products
WHERE category_id IN (1, 3, 4);

-- NOT IN example
SELECT *
FROM products
WHERE category_id NOT IN (1, 3);
