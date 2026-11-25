-- ----------------------------------------------------------------------------
-- 16. STRING FUNCTIONS
-- ----------------------------------------------------------------------------

-- Case and length
SELECT
    first_name,
    UPPER(first_name)  AS upper_name,
    LOWER(last_name)   AS lower_surname,
    LENGTH(first_name) AS name_length
FROM customers;

-- Joining strings: CONCAT, || and CONCAT_WS
SELECT
    CONCAT(first_name, ' ', last_name) AS full_name,
    first_name || ' ' || last_name     AS full_name_operator,
    CONCAT_WS(', ', city, state)       AS location
FROM customers;

-- INITCAP: capitalize the first letter of every word
SELECT INITCAP('aditi kumari sharma') AS proper_name;

-- Extracting parts: LEFT, RIGHT, SUBSTRING
SELECT
    first_name,
    LEFT(first_name, 1) || LEFT(last_name, 1) AS initials,
    RIGHT(phone, 4)                           AS last_four_digits,
    SUBSTRING(email FROM 1 FOR 5)             AS email_start
FROM customers
WHERE phone IS NOT NULL;

-- Splitting an email: SPLIT_PART and POSITION
SELECT
    email,
    SPLIT_PART(email, '@', 1)                       AS username,
    SPLIT_PART(email, '@', 2)                       AS domain,
    POSITION('@' IN email)                          AS at_position,
    SUBSTRING(email FROM 1 FOR POSITION('@' IN email) - 1) AS username_substring
FROM customers;

-- Cleaning text: REPLACE and TRIM
SELECT
    product_name,
    REPLACE(product_name, '-', ' ') AS name_without_hyphen
FROM products
WHERE product_name LIKE '%-%';

SELECT
    TRIM('   hello   ')  AS trimmed,
    LTRIM('   hello   ') AS left_trimmed,
    RTRIM('   hello   ') AS right_trimmed;

-- Padding: invoice numbers like INV-00005
SELECT
    order_id,
    'INV-' || LPAD(CAST(order_id AS TEXT), 5, '0') AS invoice_number
FROM orders
ORDER BY order_id
LIMIT 5;

-- Masking phone numbers: 98XXXXXX01
SELECT
    first_name,
    LEFT(phone, 2) || 'XXXXXX' || RIGHT(phone, 2) AS masked_phone
FROM customers
WHERE phone IS NOT NULL;

-- Regular expression match (~): phone numbers starting with 98
SELECT first_name, phone
FROM customers
WHERE phone ~ '^98';

-- STRING_AGG: combine values of a group into one string
SELECT
    state,
    COUNT(*) AS total_customers,
    STRING_AGG(first_name, ', ' ORDER BY first_name) AS customer_names
FROM customers
GROUP BY state
ORDER BY total_customers DESC, state;
