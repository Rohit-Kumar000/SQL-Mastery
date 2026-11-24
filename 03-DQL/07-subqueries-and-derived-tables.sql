-- ----------------------------------------------------------------------------
-- 9. SUBQUERIES
-- ----------------------------------------------------------------------------

-- Customers who have placed at least one cancelled order
SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE status = 'cancelled'
);

-- Products priced above the average product price
SELECT *
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);

-- Categories whose completed sales exceed Rs. 5,000
SELECT
    category_name,
    category_sales
FROM (
    SELECT
        c.category_id,
        c.category_name,
        SUM(oi.quantity * oi.unit_price) AS category_sales
    FROM categories AS c
    JOIN products AS p
        ON p.category_id = c.category_id
    JOIN order_items AS oi
        ON oi.product_id = p.product_id
    JOIN orders AS o
        ON o.order_id = oi.order_id
    WHERE o.status = 'completed'
    GROUP BY c.category_id, c.category_name
) AS category_summary
WHERE category_sales > 5000
ORDER BY category_sales DESC;


-- ----------------------------------------------------------------------------
-- 10. DERIVED TABLES
-- ----------------------------------------------------------------------------

-- Average completed-order spending by customer, using a derived table
SELECT
    customer_spending.customer_id,
    customer_spending.total_spent
FROM (
    SELECT
        o.customer_id,
        SUM(oi.quantity * oi.unit_price) AS total_spent
    FROM orders AS o
    JOIN order_items AS oi
        ON oi.order_id = o.order_id
    WHERE o.status = 'completed'
    GROUP BY o.customer_id
) AS customer_spending
ORDER BY customer_spending.total_spent DESC;
