-- ----------------------------------------------------------------------------
-- DROP / TRUNCATE
-- ----------------------------------------------------------------------------

-- Create a temporary practice table (so the real tables stay untouched)
CREATE TABLE practice_table (
    id   SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO practice_table (name) VALUES ('Test 1'), ('Test 2');

TRUNCATE TABLE practice_table;                    -- Removes all rows, keeps structure
TRUNCATE TABLE practice_table RESTART IDENTITY;   -- Also resets the ID sequence

DROP TABLE practice_table;                        -- Removes the table and its structure
