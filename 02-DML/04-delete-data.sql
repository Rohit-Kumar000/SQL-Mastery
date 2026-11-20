-- ----------------------------------------------------------------------------
-- DELETE DATA
-- ----------------------------------------------------------------------------

-- DELETE: delete only the test customer created in 03-update-data.sql
DELETE FROM customers
WHERE email = 'test.customer@example.in';
