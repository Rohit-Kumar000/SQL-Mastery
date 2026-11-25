-- ----------------------------------------------------------------------------
-- 15. EXISTS, ANY / ALL AND CORRELATED SUBQUERIES
-- ----------------------------------------------------------------------------

-- EXISTS: customers who have at least one completed order
SELECT c.customer_id, c.first_name, c.last_name
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
      AND o.status = 'completed'
);

-- NOT EXISTS: orders that have no payment record
SELECT o.order_id, o.status
FROM orders o
WHERE NOT EXISTS (
    SELECT 1
    FROM payments p
    WHERE p.order_id = o.order_id
);

-- NOT EXISTS: customers who have never had a cancelled order
SELECT c.customer_id, c.first_name, c.last_name
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
      AND o.status = 'cancelled'
);

-- Note: prefer NOT EXISTS over NOT IN.
-- If the subquery returns even one NULL, "NOT IN" returns no rows at all.

-- ANY: products priced higher than at least one Books product (category 3)
SELECT product_name, price
FROM products
WHERE price > ANY (SELECT price FROM products WHERE category_id = 3)
ORDER BY price;

-- ALL: products priced higher than every Books product
SELECT product_name, price
FROM products
WHERE price > ALL (SELECT price FROM products WHERE category_id = 3)
ORDER BY price;

-- Correlated subquery: products priced above the average of their own category
SELECT p.product_name, p.category_id, p.price
FROM products p
WHERE p.price > (
    SELECT AVG(p2.price)
    FROM products p2
    WHERE p2.category_id = p.category_id
)
ORDER BY p.category_id, p.price DESC;

-- Correlated subquery: employees earning more than their department average
SELECT e.first_name, e.last_name, e.department_id, e.salary
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
)
ORDER BY e.department_id, e.salary DESC;

-- Correlated subquery: the latest order of every customer
SELECT o.customer_id, o.order_id, o.order_date
FROM orders o
WHERE o.order_date = (
    SELECT MAX(o2.order_date)
    FROM orders o2
    WHERE o2.customer_id = o.customer_id
)
ORDER BY o.customer_id;

-- Scalar subquery in SELECT: total orders of each customer
SELECT
    c.customer_id,
    c.first_name,
    (SELECT COUNT(*) FROM orders o WHERE o.customer_id = c.customer_id) AS total_orders
FROM customers c
ORDER BY total_orders DESC, c.customer_id;

-- LATERAL join: the highest-value order of each customer
SELECT c.first_name, c.last_name, t.order_id, t.order_total
FROM customers c
CROSS JOIN LATERAL (
    SELECT o.order_id, SUM(oi.quantity * oi.unit_price) AS order_total
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.customer_id = c.customer_id
    GROUP BY o.order_id
    ORDER BY order_total DESC
    LIMIT 1
) t
ORDER BY t.order_total DESC;
