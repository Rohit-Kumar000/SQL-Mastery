-- ----------------------------------------------------------------------------
-- VERIFY SEEDED DATA
-- ----------------------------------------------------------------------------
SELECT 'departments' AS table_name, COUNT(*) AS total_records FROM departments
UNION ALL SELECT 'employees', COUNT(*) FROM employees
UNION ALL SELECT 'categories', COUNT(*) FROM categories
UNION ALL SELECT 'products', COUNT(*) FROM products
UNION ALL SELECT 'customers', COUNT(*) FROM customers
UNION ALL SELECT 'orders', COUNT(*) FROM orders
UNION ALL SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL SELECT 'payments', COUNT(*) FROM payments
ORDER BY table_name;

-- DML END
