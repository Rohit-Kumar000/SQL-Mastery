/*
===============================================================================
SQL MASTERY | 05 - TCL (Transaction Control Language)
Database: PostgreSQL

Purpose: BEGIN | COMMIT | ROLLBACK | SAVEPOINT | ISOLATION LEVELS
ACID: Atomicity | Consistency | Isolation | Durability
===============================================================================
*/


-- ----------------------------------------------------------------------------
-- PRACTICE TABLE (bank accounts, so the store data stays untouched)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS practice_accounts;

CREATE TABLE practice_accounts (
    account_id  SERIAL PRIMARY KEY,
    holder_name VARCHAR(60) NOT NULL,
    balance     NUMERIC(12, 2) NOT NULL CHECK (balance >= 0)
);

INSERT INTO practice_accounts (holder_name, balance) VALUES
    ('Aarav Sharma', 50000),
    ('Priya Verma',  30000),
    ('Rohan Mehta',  20000);

SELECT * FROM practice_accounts ORDER BY account_id;


-- ----------------------------------------------------------------------------
-- COMMIT: make the changes permanent
-- ----------------------------------------------------------------------------
-- Without BEGIN, every statement is its own transaction (auto-commit).
-- A transfer needs two updates that must succeed or fail together.

BEGIN;

UPDATE practice_accounts SET balance = balance - 5000 WHERE holder_name = 'Aarav Sharma';
UPDATE practice_accounts SET balance = balance + 5000 WHERE holder_name = 'Priya Verma';

COMMIT;

SELECT * FROM practice_accounts ORDER BY account_id;      -- Aarav 45000, Priya 35000


-- ----------------------------------------------------------------------------
-- ROLLBACK: undo everything since BEGIN
-- ----------------------------------------------------------------------------
BEGIN;

UPDATE practice_accounts SET balance = balance - 10000 WHERE holder_name = 'Rohan Mehta';

SELECT * FROM practice_accounts ORDER BY account_id;      -- Rohan shows 10000 inside the transaction

ROLLBACK;

SELECT * FROM practice_accounts ORDER BY account_id;      -- Rohan is back to 20000


-- ----------------------------------------------------------------------------
-- A REAL STORE EXAMPLE: place an order (rolled back, so seed data is unchanged)
-- ----------------------------------------------------------------------------
-- Four steps must all succeed together: order, item, payment, stock update.

BEGIN;

INSERT INTO orders (customer_id, employee_id, order_date, status, shipping_city)
VALUES (1, 5, CURRENT_DATE, 'processing', 'Delhi');

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (currval('orders_order_id_seq'), 12, 1, 899.00);

INSERT INTO payments (order_id, payment_date, amount, payment_method, status)
VALUES (currval('orders_order_id_seq'), CURRENT_DATE, 899.00, 'upi', 'success');

UPDATE products SET stock_quantity = stock_quantity - 1 WHERE product_id = 12;

SELECT * FROM orders ORDER BY order_id DESC LIMIT 1;      -- the new order is visible here

ROLLBACK;                                                  -- use COMMIT to keep the order

SELECT COUNT(*) AS total_orders FROM orders;               -- still 24
-- Note: a rolled-back INSERT still uses up a SERIAL value, so IDs can have gaps.


-- ----------------------------------------------------------------------------
-- WHAT HAPPENS ON AN ERROR
-- ----------------------------------------------------------------------------
-- If a statement fails inside a transaction, PostgreSQL marks the whole
-- transaction as aborted. Every next statement is rejected until ROLLBACK.
--
--   BEGIN;
--   UPDATE practice_accounts SET balance = balance - 99999 WHERE account_id = 1;
--   -- ERROR: violates the CHECK (balance >= 0) constraint
--   SELECT * FROM practice_accounts;
--   -- ERROR: current transaction is aborted, commands ignored until end of transaction block
--   ROLLBACK;


-- ----------------------------------------------------------------------------
-- OTHER FORMS
-- ----------------------------------------------------------------------------
-- START TRANSACTION;   is the same as BEGIN;
-- END;                 is the same as COMMIT;
-- ABORT;               is the same as ROLLBACK;

DROP TABLE IF EXISTS practice_accounts;
