-- ----------------------------------------------------------------------------
-- CHECK PRIVILEGES
-- ----------------------------------------------------------------------------

-- Table-level checks (true / false)
SELECT
    has_table_privilege('analyst_user', 'customers', 'SELECT') AS analyst_can_read_customers,
    has_table_privilege('analyst_user', 'customers', 'DELETE') AS analyst_can_delete_customers,
    has_table_privilege('sales_user',   'orders',    'INSERT') AS sales_can_insert_orders,
    has_table_privilege('sales_user',   'payments',  'UPDATE') AS sales_can_update_payments;

-- Column-level checks
SELECT
    has_column_privilege('analyst_user', 'employees', 'first_name', 'SELECT') AS can_see_first_name,
    has_column_privilege('analyst_user', 'employees', 'salary',     'SELECT') AS can_see_salary;

-- All table privileges granted to our roles
SELECT grantee, table_name, privilege_type
FROM information_schema.role_table_grants
WHERE grantee IN ('readonly_role', 'sales_role', 'hr_role')
  AND table_schema = 'public'
ORDER BY grantee, table_name, privilege_type;

-- All column-level privileges granted to our roles
SELECT grantee, table_name, column_name, privilege_type
FROM information_schema.role_column_grants
WHERE grantee IN ('readonly_role', 'sales_role', 'hr_role')
  AND table_schema = 'public'
  AND table_name IN ('employees', 'products')
ORDER BY grantee, table_name, column_name;

-- Which user belongs to which group
SELECT r.rolname AS group_role, m.rolname AS member
FROM pg_auth_members am
JOIN pg_roles r ON r.oid = am.roleid
JOIN pg_roles m ON m.oid = am.member
WHERE m.rolname IN ('analyst_user', 'sales_user')
ORDER BY m.rolname;

-- Try the permissions yourself (works when you are a superuser)
SET ROLE analyst_user;

SELECT COUNT(*) AS total_products FROM products;                         -- allowed
SELECT employee_id, first_name, job_title FROM employees LIMIT 3;        -- allowed
-- SELECT salary FROM employees;                                         -- permission denied
-- DELETE FROM customers WHERE customer_id = 1;                          -- permission denied

RESET ROLE;
