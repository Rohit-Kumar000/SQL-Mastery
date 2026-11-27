-- ----------------------------------------------------------------------------
-- ISOLATION LEVELS
-- ----------------------------------------------------------------------------
-- Isolation decides what one transaction can see of another running transaction.
--
--  Level             | Dirty read | Non-repeatable read | Phantom read
--  ------------------+------------+---------------------+-------------
--  READ UNCOMMITTED  | no (*)     | possible            | possible
--  READ COMMITTED    | no         | possible            | possible     <- PostgreSQL default
--  REPEATABLE READ   | no         | no                  | no (*)
--  SERIALIZABLE      | no         | no                  | no
--
--  (*) PostgreSQL treats READ UNCOMMITTED exactly like READ COMMITTED,
--      and its REPEATABLE READ also prevents phantom reads.
--
--  Dirty read          : reading data another transaction has not committed yet
--  Non-repeatable read : the same row gives a different value when read twice
--  Phantom read        : the same query returns different rows when run twice

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


-- Check the current level
SHOW transaction_isolation;
SHOW default_transaction_isolation;

-- Choose the level when the transaction starts
BEGIN ISOLATION LEVEL READ COMMITTED;
SELECT * FROM practice_accounts ORDER BY account_id;
COMMIT;

BEGIN ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM practice_accounts ORDER BY account_id;
COMMIT;

BEGIN ISOLATION LEVEL SERIALIZABLE;
SELECT SUM(balance) AS total_money FROM practice_accounts;
COMMIT;

-- Or set it as the first statement inside the transaction
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM practice_accounts ORDER BY account_id;
COMMIT;

-- Read-only transactions
BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY;
SELECT * FROM practice_accounts ORDER BY account_id;
COMMIT;


-- ----------------------------------------------------------------------------
-- TWO-SESSION EXPERIMENT (open two query windows and run step by step)
-- ----------------------------------------------------------------------------
-- READ COMMITTED (default): the second read sees the other session's commit
--
--   Session A                                          Session B
--   BEGIN;
--   SELECT balance FROM practice_accounts
--   WHERE holder_name = 'Aarav Sharma';   -- 50000
--                                                      BEGIN;
--                                                      UPDATE practice_accounts SET balance = 40000
--                                                      WHERE holder_name = 'Aarav Sharma';
--                                                      COMMIT;
--   SELECT balance FROM practice_accounts
--   WHERE holder_name = 'Aarav Sharma';   -- 40000 (changed)
--   COMMIT;
--
-- REPEATABLE READ: change the first line of Session A to
--   BEGIN ISOLATION LEVEL REPEATABLE READ;
-- and the second read in Session A still shows 50000 until it commits.


-- ----------------------------------------------------------------------------
-- ROW LOCKS
-- ----------------------------------------------------------------------------
-- SELECT ... FOR UPDATE locks the selected rows until the transaction ends,
-- so nobody else can change them in between (useful for "read, then update").
BEGIN;

SELECT * FROM practice_accounts WHERE holder_name = 'Aarav Sharma' FOR UPDATE;
UPDATE practice_accounts SET balance = balance - 1000 WHERE holder_name = 'Aarav Sharma';

ROLLBACK;

-- Other lock options:
--   FOR SHARE         : others can read, but cannot change the rows
--   FOR UPDATE NOWAIT : fail immediately if the rows are already locked
--   FOR UPDATE SKIP LOCKED : skip rows that are locked (job queues)
--
-- Deadlock: Session A locks row 1 then waits for row 2, while Session B locks
-- row 2 then waits for row 1. PostgreSQL detects it and cancels one session.
-- Tip: always update rows in the same order (for example, by account_id).

DROP TABLE IF EXISTS practice_accounts;

-- TCL END
