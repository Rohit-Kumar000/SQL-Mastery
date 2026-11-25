-- ----------------------------------------------------------------------------
-- 18. NUMERIC FUNCTIONS AND TYPE CASTING
-- ----------------------------------------------------------------------------

-- Common numeric functions
SELECT
    ROUND(3.14159, 2) AS rounded,
    CEIL(4.2)         AS ceiling,
    FLOOR(4.8)        AS floor_value,
    TRUNC(4.89)       AS truncated,
    ABS(-500)         AS absolute,
    MOD(17, 5)        AS remainder,
    POWER(2, 3)       AS power_value,
    SQRT(144)         AS square_root;

-- 15% discount on expensive products
SELECT
    product_name,
    price,
    ROUND(price * 0.15, 2) AS discount_amount,
    ROUND(price * 0.85, 2) AS discounted_price
FROM products
WHERE price > 2000
ORDER BY price DESC;

-- 18% GST on every product
SELECT
    product_name,
    price,
    ROUND(price * 0.18, 2) AS gst_amount,
    ROUND(price * 1.18, 2) AS price_with_gst
FROM products
ORDER BY price DESC
LIMIT 10;

-- GREATEST and LEAST
SELECT GREATEST(10, 50, 30) AS biggest, LEAST(10, 50, 30) AS smallest;

-- NULLIF: avoid division by zero
SELECT
    category_id,
    SUM(stock_quantity) AS total_stock,
    ROUND(SUM(price) / NULLIF(SUM(stock_quantity), 0), 2) AS price_per_stock_unit
FROM products
GROUP BY category_id
ORDER BY category_id;

-- Integer division pitfall
SELECT
    7 / 2              AS integer_division,   -- 3
    7 / 2.0            AS decimal_division,   -- 3.5000
    CAST(7 AS NUMERIC) / 2 AS cast_division;  -- 3.5000

-- CAST and the PostgreSQL shortcut ::
SELECT
    price,
    CAST(price AS INT)         AS price_cast,
    price::INT                 AS price_shortcut,
    CAST(product_id AS TEXT)   AS product_id_text,
    CAST('2025-06-01' AS DATE) AS date_cast,
    '2025-06-01'::DATE         AS date_shortcut
FROM products
WHERE product_id = 1;

-- Cast a number to text to join it with a string
SELECT
    product_name || ' - Rs. ' || CAST(price AS TEXT) AS price_label
FROM products
ORDER BY price DESC
LIMIT 5;

-- Casting text to numbers and dates
SELECT
    '250.75'::NUMERIC + 10 AS number_from_text,
    '2025-12-25'::DATE - DATE '2025-12-01' AS days_between,
    'true'::BOOLEAN AS boolean_from_text;
