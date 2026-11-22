-- ----------------------------------------------------------------------------
-- 5. JOINS
-- ----------------------------------------------------------------------------

-- INNER JOIN: orders that have an assigned employee
SELECT
    o.order_id,
    o.status,
    e.employee_id,
    e.first_name,
    e.last_name,
    e.email
FROM orders AS o
INNER JOIN employees AS e
    ON o.employee_id = e.employee_id;

-- LEFT JOIN: all orders, with employee details where available
SELECT
    o.order_id,
    o.status,
    e.first_name AS employee_first_name,
    e.last_name AS employee_last_name
FROM orders AS o
LEFT JOIN employees AS e
    ON o.employee_id = e.employee_id;

-- RIGHT JOIN: all employees, including employees without assigned orders
SELECT
    o.order_id,
    o.status,
    e.employee_id,
    e.first_name,
    e.last_name
FROM orders AS o
RIGHT JOIN employees AS e
    ON o.employee_id = e.employee_id;

-- FULL OUTER JOIN: all matching and non-matching rows from both sides
SELECT
    o.order_id,
    o.status,
    e.employee_id,
    e.first_name,
    e.last_name
FROM orders AS o
FULL OUTER JOIN employees AS e
    ON o.employee_id = e.employee_id;

-- CROSS JOIN: every department/category combination
SELECT
    d.department_name,
    c.category_name
FROM departments AS d
CROSS JOIN categories AS c;

-- SELF JOIN: employees and their managers
SELECT
    employee.first_name AS employee_first_name,
    employee.last_name AS employee_last_name,
    manager.first_name AS manager_first_name,
    manager.last_name AS manager_last_name
FROM employees AS employee
LEFT JOIN employees AS manager
    ON employee.manager_id = manager.employee_id;

-- Customers who have never placed an order
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email
FROM customers AS c
LEFT JOIN orders AS o
    ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL;

-- Orders with no payment record
SELECT
    o.order_id,
    o.order_date,
    o.status
FROM orders AS o
LEFT JOIN payments AS p
    ON p.order_id = o.order_id
WHERE p.payment_id IS NULL;

-- Order details with customer, product and category information
SELECT
    o.order_id,
    o.order_date,
    o.status,
    c.first_name,
    c.last_name,
    p.product_name,
    cat.category_name,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price AS line_total
FROM orders AS o
LEFT JOIN customers AS c
    ON c.customer_id = o.customer_id
LEFT JOIN order_items AS oi
    ON oi.order_id = o.order_id
LEFT JOIN products AS p
    ON p.product_id = oi.product_id
LEFT JOIN categories AS cat
    ON cat.category_id = p.category_id
ORDER BY o.order_id;
