-- ----------------------------------------------------------------------------
-- GRANT
-- ----------------------------------------------------------------------------

-- Every role needs permission to connect and to see the public schema
GRANT CONNECT ON DATABASE sql_mastery TO readonly_role, sales_role, hr_role;
GRANT USAGE ON SCHEMA public TO readonly_role, sales_role, hr_role;

-- readonly_role: can only read the store data
GRANT SELECT ON
    departments, categories, products, customers, orders, order_items, payments
TO readonly_role;

-- Column-level privilege: employees can be read, but salary, email and phone stay hidden
GRANT SELECT (employee_id, first_name, last_name, job_title, department_id, manager_id)
ON employees
TO readonly_role;

-- sales_role: read catalog data, create and update orders
GRANT SELECT ON categories, products, customers TO sales_role;
GRANT SELECT, INSERT, UPDATE ON orders, order_items, payments TO sales_role;

-- Column-level UPDATE: sales can change only the stock of a product
GRANT UPDATE (stock_quantity) ON products TO sales_role;

-- Inserting into SERIAL columns also needs permission on the sequences
GRANT USAGE, SELECT ON SEQUENCE
    orders_order_id_seq,
    order_items_order_item_id_seq,
    payments_payment_id_seq
TO sales_role;

-- hr_role: full control over employees and departments
GRANT SELECT, INSERT, UPDATE, DELETE ON employees, departments TO hr_role;
GRANT USAGE, SELECT ON SEQUENCE employees_employee_id_seq, departments_department_id_seq TO hr_role;

-- Shortcut: ALL PRIVILEGES (example, not executed)
--   GRANT ALL PRIVILEGES ON TABLE products TO hr_role;

-- Allow a user to pass the privilege on to others (example, not executed)
--   GRANT SELECT ON categories TO sales_user WITH GRANT OPTION;

-- Default privileges: tables created in the future are readable by readonly_role
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readonly_role;


-- ----------------------------------------------------------------------------
-- REVOKE
-- ----------------------------------------------------------------------------

-- Payments should not be edited by the sales team after they are recorded
REVOKE UPDATE ON payments FROM sales_role;

-- Sales team no longer needs to change the stock directly
REVOKE UPDATE (stock_quantity) ON products FROM sales_role;

-- Remove a user from a group
-- REVOKE sales_role FROM sales_user;
