-- ----------------------------------------------------------------------------
-- 20. RECURSIVE CTE
-- ----------------------------------------------------------------------------
-- Structure of every recursive CTE:
--   1. Anchor member    : the starting rows
--   2. UNION ALL
--   3. Recursive member : refers to the CTE itself and stops when no new rows appear

-- Simple example: numbers from 1 to 10
WITH RECURSIVE numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1
    FROM numbers
    WHERE n < 10
)
SELECT n
FROM numbers;

-- Employee hierarchy: who reports to whom (level and full path)
WITH RECURSIVE org_chart AS (
    SELECT
        employee_id,
        first_name,
        last_name,
        job_title,
        manager_id,
        1 AS level,
        CAST(first_name AS TEXT) AS hierarchy_path
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT
        e.employee_id,
        e.first_name,
        e.last_name,
        e.job_title,
        e.manager_id,
        oc.level + 1,
        oc.hierarchy_path || ' > ' || e.first_name
    FROM employees e
    JOIN org_chart oc ON e.manager_id = oc.employee_id
)
SELECT
    level,
    employee_id,
    first_name || ' ' || last_name AS employee_name,
    job_title,
    hierarchy_path
FROM org_chart
ORDER BY hierarchy_path;

-- Everyone working under one manager (all levels): employee 4
WITH RECURSIVE team AS (
    SELECT employee_id, first_name, last_name, manager_id
    FROM employees
    WHERE employee_id = 4

    UNION ALL

    SELECT e.employee_id, e.first_name, e.last_name, e.manager_id
    FROM employees e
    JOIN team t ON e.manager_id = t.employee_id
)
SELECT employee_id, first_name, last_name
FROM team
WHERE employee_id <> 4;

-- Customer referral chain: who referred whom
WITH RECURSIVE referral_chain AS (
    SELECT
        customer_id,
        first_name,
        referred_by,
        1 AS depth,
        CAST(first_name AS TEXT) AS chain
    FROM customers
    WHERE referred_by IS NULL

    UNION ALL

    SELECT
        c.customer_id,
        c.first_name,
        c.referred_by,
        rc.depth + 1,
        rc.chain || ' -> ' || c.first_name
    FROM customers c
    JOIN referral_chain rc ON c.referred_by = rc.customer_id
)
SELECT customer_id, first_name, depth, chain
FROM referral_chain
WHERE depth > 1
ORDER BY chain;
