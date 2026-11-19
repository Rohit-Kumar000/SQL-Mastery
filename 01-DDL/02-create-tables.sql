/*
===============================================================================
SQL MASTERY | 01 - DDL (Data Definition Language)
Database: PostgreSQL

Purpose: CREATE | ALTER | DROP | TRUNCATE
Constraints: PRIMARY KEY | FOREIGN KEY | NOT NULL | UNIQUE | CHECK | DEFAULT
===============================================================================
*/


-- ----------------------------------------------------------------------------
-- CREATE TABLE 
-- ----------------------------------------------------------------------------


-- ----------------------------------------------------------------------------
-- 1. DEPARTMENTS
-- ----------------------------------------------------------------------------
CREATE TABLE departments (
    department_id   SERIAL PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL UNIQUE
);


-- ----------------------------------------------------------------------------
-- 2. EMPLOYEES
-- ----------------------------------------------------------------------------
CREATE TABLE employees (
    employee_id     SERIAL PRIMARY KEY,
    first_name      VARCHAR(40) NOT NULL,
    last_name       VARCHAR(40) NOT NULL,
    email           VARCHAR(100) NOT NULL UNIQUE,
    phone           VARCHAR(20),
    bio             TEXT,
    job_title       VARCHAR(60) NOT NULL,
    salary          NUMERIC(10, 2) NOT NULL CHECK (salary > 0),
    is_active       BOOLEAN NOT NULL DEFAULT TRUE,
    hire_date       DATE NOT NULL,
    last_login      TIMESTAMP,
    employment_status VARCHAR(20) NOT NULL DEFAULT 'active'
                    CHECK (employment_status IN ('active', 'on_leave', 'terminated')),
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    department_id   INT REFERENCES departments(department_id),
    manager_id      INT REFERENCES employees(employee_id)
);


-- ----------------------------------------------------------------------------
-- 3. CATEGORIES
-- ----------------------------------------------------------------------------
CREATE TABLE categories (
    category_id   SERIAL PRIMARY KEY,
    category_name VARCHAR(60) NOT NULL UNIQUE,
    description   TEXT
);


-- ----------------------------------------------------------------------------
-- 4. PRODUCTS
-- ----------------------------------------------------------------------------
CREATE TABLE products (
    product_id     SERIAL PRIMARY KEY,
    category_id    INT NOT NULL REFERENCES categories(category_id),
    product_name   VARCHAR(100) NOT NULL,
    price          NUMERIC(10, 2) NOT NULL CHECK (price > 0),
    stock_quantity INT NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    is_active      BOOLEAN NOT NULL DEFAULT TRUE,
    created_at     DATE NOT NULL DEFAULT CURRENT_DATE
);


-- ----------------------------------------------------------------------------
-- 5. CUSTOMERS
-- ----------------------------------------------------------------------------
CREATE TABLE customers (
    customer_id    SERIAL PRIMARY KEY,
    first_name     VARCHAR(50) NOT NULL,
    last_name      VARCHAR(50) NOT NULL,
    email          VARCHAR(120) NOT NULL UNIQUE,
    phone          VARCHAR(20),
    city           VARCHAR(60),
    state          VARCHAR(60),
    country        VARCHAR(50) NOT NULL DEFAULT 'India',
    signup_date    DATE NOT NULL DEFAULT CURRENT_DATE,
    loyalty_points INT NOT NULL DEFAULT 0 CHECK (loyalty_points >= 0),
    referred_by    INT REFERENCES customers(customer_id)
);


-- ----------------------------------------------------------------------------
-- 6. ORDERS
-- ----------------------------------------------------------------------------
CREATE TABLE orders (
    order_id      SERIAL PRIMARY KEY,
    customer_id   INT NOT NULL REFERENCES customers(customer_id),
    employee_id   INT REFERENCES employees(employee_id),
    order_date    DATE NOT NULL DEFAULT CURRENT_DATE,
    status        VARCHAR(20) NOT NULL DEFAULT 'pending'
                  CHECK (status IN ('pending', 'processing', 'completed', 'cancelled', 'refunded')),
    shipping_city VARCHAR(60),
    notes         TEXT
);


-- ----------------------------------------------------------------------------
-- 7. ORDER ITEMS
-- ----------------------------------------------------------------------------
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id      INT NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id    INT NOT NULL REFERENCES products(product_id),
    quantity      INT NOT NULL CHECK (quantity > 0),
    unit_price    NUMERIC(10, 2) NOT NULL CHECK (unit_price > 0),
    CONSTRAINT uq_order_product UNIQUE (order_id, product_id)
);


-- ----------------------------------------------------------------------------
-- 8. PAYMENTS
-- ----------------------------------------------------------------------------
CREATE TABLE payments (
    payment_id     SERIAL PRIMARY KEY,
    order_id       INT NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    payment_date   DATE NOT NULL DEFAULT CURRENT_DATE,
    amount         NUMERIC(10, 2) NOT NULL CHECK (amount > 0),
    payment_method VARCHAR(20) NOT NULL
                   CHECK (payment_method IN ('upi', 'card', 'net_banking', 'cash', 'wallet')),
    status         VARCHAR(20) NOT NULL DEFAULT 'success'
                   CHECK (status IN ('success', 'failed', 'refunded'))
);
