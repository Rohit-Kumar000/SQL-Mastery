-- ----------------------------------------------------------------------------
-- 3. LIKE, NULL AND COALESCE
-- ----------------------------------------------------------------------------

-- Product names containing "Electric" (case-sensitive)
SELECT *
FROM products
WHERE product_name LIKE '%Electric%';

-- Case-insensitive pattern search in PostgreSQL (ILIKE)
SELECT *
FROM products
WHERE product_name ILIKE '%mouse%';

-- Customers who have not provided a phone number
SELECT *
FROM customers
WHERE phone IS NULL;

-- Customers who have provided a phone number
SELECT *
FROM customers
WHERE phone IS NOT NULL;

-- COALESCE: display a fallback value when a field is NULL
SELECT
    first_name,
    last_name,
    COALESCE(phone, 'Phone unavailable') AS phone_number,
    COALESCE(city, 'City unavailable') AS city
FROM customers;
