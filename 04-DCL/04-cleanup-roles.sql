-- ----------------------------------------------------------------------------
-- CLEANUP (run this when you want to remove the practice roles)
-- ----------------------------------------------------------------------------
-- A role cannot be dropped while it still holds privileges,
-- so everything is revoked first.

ALTER DEFAULT PRIVILEGES IN SCHEMA public REVOKE SELECT ON TABLES FROM readonly_role;

REVOKE ALL ON ALL TABLES    IN SCHEMA public FROM readonly_role, sales_role, hr_role;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA public FROM readonly_role, sales_role, hr_role;
REVOKE ALL ON SCHEMA public FROM readonly_role, sales_role, hr_role;
REVOKE ALL ON DATABASE sql_mastery FROM readonly_role, sales_role, hr_role;

DROP ROLE IF EXISTS analyst_user;
DROP ROLE IF EXISTS sales_user;
DROP ROLE IF EXISTS readonly_role;
DROP ROLE IF EXISTS sales_role;
DROP ROLE IF EXISTS hr_role;

-- DCL END
