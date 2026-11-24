-- ----------------------------------------------------------------------------
-- 6. AGGREGATE FUNCTIONS
-- ----------------------------------------------------------------------------

-- Count customers and customers who have a phone number
SELECT
    COUNT(*) AS total_customers,
    COUNT(phone) AS customers_with_phone
FROM customers;

-- Count distinct customer cities
SELECT COUNT(DISTINCT city) AS distinct_cities
FROM customers
WHERE city IS NOT NULL;

-- Calculate line totals
SELECT
    order_item_id,
    quantity,
    unit_price,
    quantity * unit_price AS line_total
FROM order_items;

-- Total value of all order items (includes all order statuses)
SELECT SUM(quantity * unit_price) AS total_order_item_value
FROM order_items;

-- Average product price
SELECT ROUND(AVG(price), 2) AS average_product_price
FROM products;

-- Minimum and maximum product prices
SELECT
    MIN(price) AS minimum_price,
    MAX(price) AS maximum_price
FROM products;

-- Multiple aggregate calculations
SELECT
    COUNT(*) AS total_products,
    ROUND(AVG(price), 2) AS average_price,
    MIN(price) AS minimum_price,
    MAX(price) AS maximum_price,
    SUM(stock_quantity) AS total_stock
FROM products;


-- ----------------------------------------------------------------------------
-- 7. GROUP BY
-- ----------------------------------------------------------------------------

-- Number of products in each category
SELECT
    category_id,
    COUNT(*) AS product_count
FROM products
GROUP BY category_id
ORDER BY category_id;

-- Active and inactive product counts by category
SELECT
    category_id,
    is_active,
    COUNT(*) AS product_count
FROM products
GROUP BY category_id, is_active
ORDER BY category_id, is_active;

-- Category names and product counts
SELECT
    c.category_id,
    c.category_name,
    COUNT(p.product_id) AS product_count
FROM categories AS c
LEFT JOIN products AS p
    ON p.category_id = c.category_id
GROUP BY c.category_id, c.category_name
ORDER BY c.category_id;

-- Total sales value by category
SELECT
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
ORDER BY category_sales DESC;


-- ----------------------------------------------------------------------------
-- 8. HAVING
-- ----------------------------------------------------------------------------

-- Categories with more than 3 products
SELECT
    category_id,
    COUNT(*) AS product_count
FROM products
GROUP BY category_id
HAVING COUNT(*) > 3;

-- Departments with more than one employee and total salary above Rs. 1,00,000
SELECT
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    SUM(e.salary) AS department_salary
FROM departments AS d
JOIN employees AS e
    ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(e.employee_id) > 1
   AND SUM(e.salary) > 100000;
