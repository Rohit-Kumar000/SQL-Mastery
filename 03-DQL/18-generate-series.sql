-- ----------------------------------------------------------------------------
-- 21. GENERATE_SERIES
-- ----------------------------------------------------------------------------
-- generate_series(start, stop [, step]) produces a list of rows: numbers, dates
-- or timestamps. It is useful for calendars, filling gaps in reports and
-- creating test data.

-- Numbers
SELECT generate_series(1, 5) AS n;
SELECT * FROM generate_series(1, 5) AS g(n);

-- With a step
SELECT * FROM generate_series(0, 100, 25) AS g(value);       -- 0, 25, 50, 75, 100

-- Counting down
SELECT * FROM generate_series(10, 1, -3) AS g(value);        -- 10, 7, 4, 1

-- Decimal steps
SELECT * FROM generate_series(0, 1, 0.25) AS g(value);

-- Position of every row
SELECT * FROM generate_series(10, 50, 10) WITH ORDINALITY AS g(value, row_position);


-- ----------------------------------------------------------------------------
-- DATES AND TIMESTAMPS
-- ----------------------------------------------------------------------------

-- Every day of a week
SELECT CAST(g.day AS DATE) AS day
FROM generate_series(DATE '2025-06-01', DATE '2025-06-07', INTERVAL '1 day') AS g(day);

-- First day of every month in 2025
SELECT CAST(g.month_start AS DATE) AS month_start
FROM generate_series(DATE '2025-01-01', DATE '2025-12-01', INTERVAL '1 month') AS g(month_start);

-- Every 2 hours
SELECT *
FROM generate_series(
    TIMESTAMP '2025-06-01 00:00',
    TIMESTAMP '2025-06-01 08:00',
    INTERVAL '2 hours'
) AS g(slot);

-- A small calendar table
SELECT
    CAST(g.day AS DATE)       AS calendar_date,
    TO_CHAR(g.day, 'FMDay')   AS weekday,
    EXTRACT(WEEK FROM g.day)  AS week_number,
    EXTRACT(DOW FROM g.day) IN (0, 6) AS is_weekend
FROM generate_series(DATE '2025-06-01', DATE '2025-06-14', INTERVAL '1 day') AS g(day);


-- ----------------------------------------------------------------------------
-- FILLING GAPS IN A REPORT
-- ----------------------------------------------------------------------------
-- A normal GROUP BY shows only days that have orders.
-- Joining a generated calendar shows every day, with 0 for the empty ones.
SELECT
    CAST(d.day AS DATE)                           AS sale_date,
    COUNT(DISTINCT o.order_id)                    AS completed_orders,
    COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total_sales
FROM generate_series(DATE '2025-06-01', DATE '2025-06-15', INTERVAL '1 day') AS d(day)
LEFT JOIN orders o
       ON o.order_date = CAST(d.day AS DATE)
      AND o.status = 'completed'
LEFT JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY d.day
ORDER BY d.day;

-- Every month from May to August, even the months without sales
SELECT
    CAST(m.month_start AS DATE)                   AS sales_month,
    COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total_sales
FROM generate_series(DATE '2025-05-01', DATE '2025-08-01', INTERVAL '1 month') AS m(month_start)
LEFT JOIN orders o
       ON DATE_TRUNC('month', o.order_date) = m.month_start
      AND o.status = 'completed'
LEFT JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY m.month_start
ORDER BY m.month_start;


-- ----------------------------------------------------------------------------
-- COMBINING WITH OTHER TABLES
-- ----------------------------------------------------------------------------

-- Every product with the quantities 1 to 3 (CROSS JOIN)
SELECT p.product_name, q.quantity, p.price * q.quantity AS line_total
FROM products p
CROSS JOIN generate_series(1, 3) AS q(quantity)
WHERE p.category_id = 3
ORDER BY p.product_name, q.quantity;

-- Find missing IDs: order numbers that do not exist
SELECT g.id AS missing_order_id
FROM generate_series(1, 30) AS g(id)
LEFT JOIN orders o ON o.order_id = g.id
WHERE o.order_id IS NULL
ORDER BY g.id;


-- ----------------------------------------------------------------------------
-- CREATING TEST DATA
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS practice_test_data;

CREATE TABLE practice_test_data AS
SELECT
    n                                                  AS id,
    'user_' || n                                       AS username,
    ROUND(CAST(random() * 1000 AS NUMERIC), 2)         AS score,
    (ARRAY['Delhi', 'Mumbai', 'Pune', 'Chennai', 'Kolkata'])[1 + FLOOR(random() * 5)::INT] AS city,
    CURRENT_DATE - (FLOOR(random() * 365))::INT        AS joined_on,
    md5(CAST(n AS TEXT))                               AS hash
FROM generate_series(1, 1000) AS g(n);

SELECT COUNT(*) AS total_rows, MIN(score) AS min_score, MAX(score) AS max_score, ROUND(AVG(score), 2) AS avg_score
FROM practice_test_data;

SELECT city, COUNT(*) AS users
FROM practice_test_data
GROUP BY city
ORDER BY users DESC;

-- random() gives a different result every time. For repeatable results, set a seed first:
--   SELECT setseed(0.42);

DROP TABLE IF EXISTS practice_test_data;

-- DQL END
