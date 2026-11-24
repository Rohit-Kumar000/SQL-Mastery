-- ----------------------------------------------------------------------------
-- 11. CTE (COMMON TABLE EXPRESSIONS)
-- ----------------------------------------------------------------------------

-- Category-wise completed sales
WITH category_sales AS (
    SELECT
        p.category_id,
        SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM products AS p
    JOIN order_items AS oi
        ON oi.product_id = p.product_id
    JOIN orders AS o
        ON o.order_id = oi.order_id
    WHERE o.status = 'completed'
    GROUP BY p.category_id
)
SELECT
    c.category_name,
    cs.total_sales
FROM category_sales AS cs
JOIN categories AS c
    ON c.category_id = cs.category_id
ORDER BY cs.total_sales DESC;

-- Multiple CTEs: highest-selling category
WITH category_sales AS (
    SELECT
        p.category_id,
        SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM products AS p
    JOIN order_items AS oi
        ON oi.product_id = p.product_id
    JOIN orders AS o
        ON o.order_id = oi.order_id
    WHERE o.status = 'completed'
    GROUP BY p.category_id
),
top_category AS (
    SELECT *
    FROM category_sales
    ORDER BY total_sales DESC
    LIMIT 1
)
SELECT
    c.category_name,
    tc.total_sales
FROM top_category AS tc
JOIN categories AS c
    ON c.category_id = tc.category_id;

-- Customer spending compared with the average customer spending
WITH customer_totals AS (
    SELECT
        o.customer_id,
        SUM(oi.quantity * oi.unit_price) AS customer_spending
    FROM orders AS o
    JOIN order_items AS oi
        ON oi.order_id = o.order_id
    WHERE o.status = 'completed'
    GROUP BY o.customer_id
)
SELECT
    ct.customer_id,
    ct.customer_spending,
    ROUND((SELECT AVG(customer_spending) FROM customer_totals), 2) AS average_spending,
    ct.customer_spending > (SELECT AVG(customer_spending) FROM customer_totals) AS above_average
FROM customer_totals AS ct
ORDER BY ct.customer_spending DESC;
