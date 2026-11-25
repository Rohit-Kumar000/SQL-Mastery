-- ----------------------------------------------------------------------------
-- 17. DATE AND TIME FUNCTIONS
-- ----------------------------------------------------------------------------

-- Current date and time
SELECT
    CURRENT_DATE      AS today,
    CURRENT_TIMESTAMP AS right_now,
    NOW()             AS also_right_now;

-- EXTRACT: pull one part out of a date
SELECT
    order_id,
    order_date,
    EXTRACT(YEAR  FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    EXTRACT(DAY   FROM order_date) AS order_day,
    EXTRACT(DOW   FROM order_date) AS day_of_week      -- 0 = Sunday ... 6 = Saturday
FROM orders
ORDER BY order_date;

-- TO_CHAR: format a date as text
SELECT
    order_id,
    TO_CHAR(order_date, 'DD Mon YYYY')  AS formatted_date,
    TO_CHAR(order_date, 'FMDay')        AS weekday_name,
    TO_CHAR(order_date, 'Mon-YYYY')     AS month_year
FROM orders
ORDER BY order_date;

-- DATE_TRUNC: monthly sales of completed orders
SELECT
    CAST(DATE_TRUNC('month', o.order_date) AS DATE) AS order_month,
    COUNT(DISTINCT o.order_id)                      AS total_orders,
    SUM(oi.quantity * oi.unit_price)                AS total_sales
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY DATE_TRUNC('month', o.order_date)
ORDER BY order_month;

-- Date arithmetic
SELECT
    order_id,
    order_date,
    order_date + 7                                       AS expected_delivery,
    CAST(order_date + INTERVAL '1 month' AS DATE)        AS one_month_later,
    CAST(order_date - INTERVAL '10 days' AS DATE)        AS ten_days_earlier
FROM orders
ORDER BY order_id
LIMIT 5;

-- Difference between two dates and AGE()
SELECT
    first_name,
    signup_date,
    CURRENT_DATE - signup_date              AS days_since_signup,
    AGE(CURRENT_DATE, signup_date)          AS account_age
FROM customers
ORDER BY signup_date;

-- Employee tenure in years
SELECT
    first_name,
    last_name,
    hire_date,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, hire_date)) AS years_with_company
FROM employees
ORDER BY hire_date;

-- Orders placed in June 2025 (a safe way to filter a whole month)
SELECT order_id, order_date, status
FROM orders
WHERE order_date >= DATE '2025-06-01'
  AND order_date <  DATE '2025-07-01'
ORDER BY order_date;

-- Orders per weekday
SELECT
    TO_CHAR(order_date, 'FMDay') AS weekday_name,
    COUNT(*)                     AS total_orders
FROM orders
GROUP BY TO_CHAR(order_date, 'FMDay'), EXTRACT(DOW FROM order_date)
ORDER BY EXTRACT(DOW FROM order_date);
