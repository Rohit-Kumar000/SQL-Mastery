-- ----------------------------------------------------------------------------
-- SAVEPOINT: roll back only a part of a transaction
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


-- Money is debited from Aarav, but credited to the wrong person by mistake.
-- With a savepoint we fix only the second step, not the whole transaction.
BEGIN;

UPDATE practice_accounts SET balance = balance - 2000 WHERE holder_name = 'Aarav Sharma';

SAVEPOINT debit_done;

UPDATE practice_accounts SET balance = balance + 2000 WHERE holder_name = 'Wrong Person';   -- 0 rows updated

ROLLBACK TO SAVEPOINT debit_done;                -- undo only the wrong credit

UPDATE practice_accounts SET balance = balance + 2000 WHERE holder_name = 'Rohan Mehta';

COMMIT;

SELECT * FROM practice_accounts ORDER BY account_id;     -- Aarav 48000, Rohan 22000


-- Multiple savepoints
BEGIN;

UPDATE practice_accounts SET balance = balance + 100 WHERE holder_name = 'Aarav Sharma';
SAVEPOINT step_one;

UPDATE practice_accounts SET balance = balance + 200 WHERE holder_name = 'Priya Verma';
SAVEPOINT step_two;

UPDATE practice_accounts SET balance = balance + 300 WHERE holder_name = 'Rohan Mehta';

ROLLBACK TO SAVEPOINT step_two;                  -- undo only the Rohan update
SELECT * FROM practice_accounts ORDER BY account_id;

ROLLBACK TO SAVEPOINT step_one;                  -- undo the Priya update as well
SELECT * FROM practice_accounts ORDER BY account_id;

RELEASE SAVEPOINT step_one;                      -- remove the savepoint (keeps the changes)

COMMIT;

SELECT * FROM practice_accounts ORDER BY account_id;     -- only Aarav's +100 remains

DROP TABLE IF EXISTS practice_accounts;
