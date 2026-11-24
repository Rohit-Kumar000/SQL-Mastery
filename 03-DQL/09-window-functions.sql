-- ----------------------------------------------------------------------------
-- 12. WINDOW FUNCTIONS
-- ----------------------------------------------------------------------------

-- Category-level sum without reducing the number of product rows
SELECT
    product_id,
    product_name,
    category_id,
    price,
    SUM(price) OVER (PARTITION BY category_id) AS category_price_total
FROM products;

-- Overall average price on each product row
SELECT
    product_id,
    product_name,
    price,
    ROUND(AVG(price) OVER (), 2) AS overall_average_price
FROM products;

-- Rank products by price
SELECT
    product_name,
    price,
    ROW_NUMBER() OVER (ORDER BY price DESC) AS price_row_number,
    RANK() OVER (ORDER BY price DESC) AS product_rank,
    DENSE_RANK() OVER (ORDER BY price DESC) AS price_dense_rank
FROM products;

-- Rank products within their own category
SELECT
    category_id,
    product_name,
    price,
    DENSE_RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS category_rank
FROM products;
