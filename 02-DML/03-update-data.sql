-- ----------------------------------------------------------------------------
-- UPDATE DATA
-- ----------------------------------------------------------------------------

-- Create a test customer first, so the seed data stays unchanged
INSERT INTO customers (first_name, last_name, email, phone, city, state)
VALUES ('Test', 'Customer', 'test.customer@example.in', '9999999999', 'Delhi', 'Delhi');

-- UPDATE: update the test customer's loyalty points
UPDATE customers
SET loyalty_points = 100
WHERE email = 'test.customer@example.in';

-- Check the result
SELECT customer_id, first_name, last_name, loyalty_points
FROM customers
WHERE email = 'test.customer@example.in';
