-- ----------------------------------------------------------------------------
-- 13. SET OPERATIONS (UNION, UNION ALL, INTERSECT, EXCEPT)
-- ----------------------------------------------------------------------------

-- A combined list of employees and customers
SELECT first_name, last_name, 'employee' AS person_type
FROM employees
UNION
SELECT first_name, last_name, 'customer' AS person_type
FROM customers;

-- UNION ALL keeps duplicate rows (if any)
SELECT first_name, last_name, 'employee' AS person_type
FROM employees
UNION ALL
SELECT first_name, last_name, 'customer' AS person_type
FROM customers;

-- INTERSECT: customers who have both a completed order and a processing order
SELECT customer_id
FROM orders
WHERE status = 'completed'
INTERSECT
SELECT customer_id
FROM orders
WHERE status = 'processing';

-- EXCEPT: customers who placed orders but never had a cancelled order
SELECT customer_id
FROM orders
EXCEPT
SELECT customer_id
FROM orders
WHERE status = 'cancelled';

-- Rules for all set operations:
--   1. Both queries must return the same number of columns
--   2. Matching columns must have compatible data types
--   3. ORDER BY (if used) goes only at the very end
