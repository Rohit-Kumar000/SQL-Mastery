/*
===============================================================================
SQL MASTERY | 04 - DCL (Data Control Language)
Database: PostgreSQL

Purpose: CREATE ROLE | GRANT | REVOKE
Run these files as a superuser (for example: postgres) while connected to
the sql_mastery database.
===============================================================================
*/


-- ----------------------------------------------------------------------------
-- ROLES
-- ----------------------------------------------------------------------------
-- In PostgreSQL, users and groups are both "roles".
--   * A role with LOGIN can connect to the database (acts like a user)
--   * A role with NOLOGIN is used as a group that holds privileges
-- Roles belong to the whole PostgreSQL server, not to one database.

-- Group roles (hold the privileges)
CREATE ROLE readonly_role NOLOGIN;
CREATE ROLE sales_role    NOLOGIN;
CREATE ROLE hr_role       NOLOGIN;

-- Login roles (real users). Change the passwords for real projects.
CREATE ROLE analyst_user LOGIN PASSWORD 'ChangeMe@123';
CREATE ROLE sales_user   LOGIN PASSWORD 'ChangeMe@123';

-- Membership: users inherit the privileges of the groups they belong to
GRANT readonly_role TO analyst_user;
GRANT sales_role    TO sales_user;

-- Role attributes
ALTER ROLE analyst_user CONNECTION LIMIT 5;
ALTER ROLE sales_user   VALID UNTIL '2030-12-31';

-- Other common attributes (examples, not executed):
--   CREATE ROLE dev_user LOGIN PASSWORD '...' CREATEDB;     -- can create databases
--   CREATE ROLE admin_user LOGIN PASSWORD '...' CREATEROLE; -- can manage roles
--   ALTER ROLE analyst_user PASSWORD 'NewPassword@456';     -- change a password

-- List the roles we created
SELECT rolname, rolcanlogin, rolsuper, rolconnlimit
FROM pg_roles
WHERE rolname IN ('readonly_role', 'sales_role', 'hr_role', 'analyst_user', 'sales_user')
ORDER BY rolname;
