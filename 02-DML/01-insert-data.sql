/*
===============================================================================
SQL MASTERY | 02 - DML (Data Manipulation Language)
Database: PostgreSQL

Purpose: INSERT | UPDATE | DELETE
CRUD: Create | Read | Update | Delete
===============================================================================
*/


-- ----------------------------------------------------------------------------
-- CREATE DATA 
-- ----------------------------------------------------------------------------


-- ----------------------------------------------------------------------------
-- 1. INSERT DEPARTMENTS
-- ----------------------------------------------------------------------------
INSERT INTO departments (department_name)
VALUES
    ('Engineering'),
    ('Sales'),
    ('Marketing'),
    ('Finance'),
    ('Human Resources');


-- ----------------------------------------------------------------------------
-- 2. INSERT EMPLOYEES
-- ----------------------------------------------------------------------------
INSERT INTO employees (
    first_name, last_name, email, phone, job_title, salary,
    hire_date, department_id, manager_id
)
VALUES
    ('Aarav',  'Sharma',  'aarav.sharma@shopdemo.in',  '9876501001', 'Engineering Manager', 95000, '2022-04-11', 1, NULL),
    ('Priya',  'Verma',   'priya.verma@shopdemo.in',   '9876501002', 'Frontend Developer',  65000, '2023-01-16', 1, 1),
    ('Rohan',  'Mehta',   'rohan.mehta@shopdemo.in',    '9876501003', 'Backend Developer',   70000, '2022-08-22', 1, 1),
    ('Neha',   'Gupta',   'neha.gupta@shopdemo.in',     '9876501004', 'Sales Manager',       80000, '2022-06-01', 2, NULL),
    ('Vikram', 'Singh',   'vikram.singh@shopdemo.in',   '9876501005', 'Sales Executive',     42000, '2023-03-13', 2, 4),
    ('Ananya', 'Iyer',    'ananya.iyer@shopdemo.in',    '9876501006', 'Marketing Manager',   76000, '2022-09-05', 3, NULL),
    ('Kabir',  'Malhotra','kabir.malhotra@shopdemo.in', '9876501007', 'Content Specialist',  45000, '2023-05-08', 3, 6),
    ('Sanya',  'Kapoor',  'sanya.kapoor@shopdemo.in',   '9876501008', 'Accountant',          52000, '2023-02-20', 4, NULL),
    ('Arjun',  'Reddy',   'arjun.reddy@shopdemo.in',    '9876501009', 'HR Executive',        48000, '2023-07-17', 5, NULL);


-- ----------------------------------------------------------------------------
-- 3. INSERT CATEGORIES
-- ----------------------------------------------------------------------------
INSERT INTO categories (category_name, description)
VALUES
    ('Electronics', 'Computer accessories and electronic devices'),
    ('Home & Kitchen', 'Useful appliances and home essentials'),
    ('Books', 'Technical, educational and general reading books'),
    ('Clothing', 'Everyday clothing and accessories'),
    ('Sports & Fitness', 'Fitness, sports and outdoor products'),
    ('Personal Care', 'Personal care and grooming products');


-- ----------------------------------------------------------------------------
-- 4. INSERT PRODUCTS
-- ----------------------------------------------------------------------------
INSERT INTO products (category_id, product_name, price, stock_quantity, is_active, created_at)
VALUES
    (1, 'Wireless Mouse', 799.00, 85, TRUE, '2025-01-10'),
    (1, 'Mechanical Keyboard', 2499.00, 32, TRUE, '2025-01-12'),
    (1, 'USB-C Hub', 1599.00, 0, TRUE, '2025-01-15'),
    (1, '27-inch Monitor', 12499.00, 14, TRUE, '2025-01-18'),
    (1, 'Bluetooth Headphones', 3299.00, 27, TRUE, '2025-01-20'),
    (2, 'Electric Kettle', 1299.00, 50, TRUE, '2025-01-22'),
    (2, 'Non-stick Tawa', 899.00, 65, TRUE, '2025-01-24'),
    (2, 'Mixer Grinder', 3499.00, 18, TRUE, '2025-01-26'),
    (2, 'Air Fryer', 5999.00, 12, TRUE, '2025-01-28'),
    (3, 'Learning SQL', 599.00, 40, TRUE, '2025-02-01'),
    (3, 'Clean Code', 799.00, 22, TRUE, '2025-02-03'),
    (3, 'The Pragmatic Programmer', 899.00, 16, TRUE, '2025-02-05'),
    (3, 'Atomic Habits', 499.00, 75, TRUE, '2025-02-07'),
    (3, 'Deep Work', 450.00, 35, TRUE, '2025-02-09'),
    (4, 'Cotton T-shirt', 599.00, 100, TRUE, '2025-02-11'),
    (4, 'Denim Jacket', 2199.00, 24, TRUE, '2025-02-13'),
    (4, 'Running Shoes', 2799.00, 30, TRUE, '2025-02-15'),
    (4, 'Winter Hoodie', 1499.00, 20, FALSE, '2025-02-17'),
    (5, 'Yoga Mat', 999.00, 55, TRUE, '2025-02-19'),
    (5, 'Dumbbell Set 10kg', 1999.00, 15, TRUE, '2025-02-21'),
    (5, 'Skipping Rope', 299.00, 90, TRUE, '2025-02-23'),
    (5, 'Cycling Helmet', 1499.00, 18, TRUE, '2025-02-25'),
    (6, 'Face Moisturizer', 399.00, 60, TRUE, '2025-02-27'),
    (6, 'Electric Trimmer', 1799.00, 25, TRUE, '2025-03-01');


-- ----------------------------------------------------------------------------
-- 5. INSERT CUSTOMERS
-- ----------------------------------------------------------------------------
INSERT INTO customers (
    first_name, last_name, email, phone, city, state, country,
    signup_date, loyalty_points, referred_by
)
VALUES
    ('Aditi',   'Sharma',   'aditi.sharma@example.in',   '9810001001', 'Delhi',       'Delhi',            'India', '2025-01-05', 320, NULL),
    ('Rahul',   'Verma',    'rahul.verma@example.in',    '9810001002', 'Noida',       'Uttar Pradesh',    'India', '2025-01-12', 180, 1),
    ('Ishita',  'Patel',    'ishita.patel@example.in',   '9810001003', 'Ahmedabad',   'Gujarat',           'India', '2025-01-20', 95,  NULL),
    ('Manpreet','Kaur',    'manpreet.kaur@example.in',  NULL,         'Chandigarh',  'Chandigarh',        'India', '2025-02-02', 0,   NULL),
    ('Sneha',   'Reddy',    'sneha.reddy@example.in',    '9810001005', 'Hyderabad',   'Telangana',         'India', '2025-02-10', 260, 1),
    ('Aditya',  'Joshi',    'aditya.joshi@example.in',   '9810001006', 'Pune',        'Maharashtra',       'India', '2025-02-18', 75,  NULL),
    ('Kavya',   'Nair',     'kavya.nair@example.in',     '9810001007', 'Kochi',       'Kerala',            'India', '2025-03-01', 500, 3),
    ('Siddharth','Bansal',  'siddharth.bansal@example.in','9810001008', 'Jaipur',      'Rajasthan',         'India', '2025-03-08', 45,  NULL),
    ('Meera',   'Chopra',   'meera.chopra@example.in',   NULL,         'Ludhiana',    'Punjab',            'India', '2025-03-15', 0,   2),
    ('Yash',    'Malhotra', 'yash.malhotra@example.in',  '9810001010', 'Mumbai',       'Maharashtra',       'India', '2025-03-22', 130, NULL),
    ('Pooja',   'Iyer',     'pooja.iyer@example.in',     '9810001011', 'Chennai',      'Tamil Nadu',        'India', '2025-04-02', 210, 7),
    ('Dhruv',   'Singh',    'dhruv.singh@example.in',    NULL,         'Lucknow',      'Uttar Pradesh',     'India', '2025-04-10', 20,  NULL),
    ('Riya',    'Das',      'riya.das@example.in',       '9810001013', 'Kolkata',      'West Bengal',        'India', '2025-04-18', 85,  NULL),
    ('Karan',   'Arora',    'karan.arora@example.in',    '9810001014', 'Gurugram',     'Haryana',            'India', '2025-04-25', 400, 10),
    ('Nandini', 'Mishra',   'nandini.mishra@example.in', NULL,         'Varanasi',     'Uttar Pradesh',     'India', '2025-05-04', 10,  NULL);


-- ----------------------------------------------------------------------------
-- 6. INSERT ORDERS
-- ----------------------------------------------------------------------------
INSERT INTO orders (customer_id, employee_id, order_date, status, shipping_city, notes)
VALUES
    (1, 5, '2025-05-02', 'completed',  'Delhi',       'Delivered successfully'),
    (2, 5, '2025-05-04', 'completed',  'Noida',       NULL),
    (3, 4, '2025-05-06', 'processing', 'Ahmedabad',   'Packed and ready to ship'),
    (4, NULL,'2025-05-08', 'cancelled', 'Chandigarh', 'Customer cancelled'),
    (5, 5, '2025-05-10', 'completed',  'Hyderabad',   NULL),
    (6, 4, '2025-05-12', 'completed',  'Pune',        NULL),
    (7, NULL,'2025-05-14', 'pending',   'Kochi',       'Awaiting confirmation'),
    (8, 5, '2025-05-16', 'completed',  'Jaipur',      NULL),
    (9, 4, '2025-05-18', 'completed',  'Ludhiana',    NULL),
    (10,5, '2025-05-20', 'refunded',   'Mumbai',      'Refund processed'),
    (11,4, '2025-05-22', 'completed',  'Chennai',     NULL),
    (12,NULL,'2025-05-24', 'completed', 'Lucknow',     NULL),
    (13,5, '2025-05-26', 'completed',  'Kolkata',     NULL),
    (14,4, '2025-05-28', 'completed',  'Gurugram',    NULL),
    (15,NULL,'2025-05-30', 'pending',   'Varanasi',    NULL),
    (1, 5, '2025-06-02', 'completed',  'Delhi',        'Repeat customer'),
    (2, 4, '2025-06-04', 'completed',  'Noida',        NULL),
    (5, 5, '2025-06-06', 'cancelled',  'Hyderabad',    NULL),
    (7, 4, '2025-06-08', 'completed',  'Kochi',        NULL),
    (10,NULL,'2025-06-10', 'completed', 'Mumbai',        NULL),
    (3, 5, '2025-06-12', 'completed',  'Ahmedabad',     NULL),
    (8, 4, '2025-06-14', 'processing', 'Jaipur',        NULL),
    (11,5, '2025-06-16', 'completed',  'Chennai',       NULL),
    (14,NULL,'2025-06-18', 'completed', 'Gurugram',      NULL);


-- ----------------------------------------------------------------------------
-- 7. INSERT ORDER ITEMS
-- ----------------------------------------------------------------------------
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES
    (1, 1, 1, 799.00),  (1, 10, 1, 599.00),
    (2, 2, 1, 2499.00), (2, 15, 2, 599.00),
    (3, 5, 1, 3299.00), (3, 6, 1, 1299.00),
    (4, 21, 2, 299.00),
    (5, 8, 1, 3499.00), (5, 23, 2, 399.00),
    (6, 17, 1, 2799.00), (6, 19, 1, 999.00),
    (7, 20, 1, 1999.00),
    (8, 12, 1, 899.00), (8, 13, 2, 499.00),
    (9, 16, 1, 2199.00), (9, 18, 1, 1499.00),
    (10,24, 1, 1799.00),
    (11, 9, 1, 5999.00), (11, 7, 1, 899.00),
    (12, 3, 1, 1599.00), (12, 1, 1, 799.00),
    (13,11, 1, 799.00), (13,14, 2, 450.00),
    (14, 4, 1, 12499.00),
    (15,21, 3, 299.00),
    (16, 5, 1, 3299.00), (16, 2, 1, 2499.00),
    (17, 6, 2, 1299.00), (17, 7, 1, 899.00),
    (18,23, 1, 399.00),
    (19,19, 1, 999.00), (19,20, 1, 1999.00),
    (20, 8, 1, 3499.00), (20, 9, 1, 5999.00),
    (21,13, 1, 499.00), (21,10, 1, 599.00),
    (22,22, 1, 1499.00), (22,21, 2, 299.00),
    (23,15, 3, 599.00), (23,18, 1, 1499.00),
    (24,17, 1, 2799.00), (24,24, 1, 1799.00);


-- ----------------------------------------------------------------------------
-- 8. INSERT PAYMENTS
-- Payments are recorded for orders with a payment attempt.
-- ----------------------------------------------------------------------------
INSERT INTO payments (order_id, payment_date, amount, payment_method, status)
VALUES
    (1,  '2025-05-02', 1398.00, 'upi',         'success'),
    (2,  '2025-05-04', 3697.00, 'card',        'success'),
    (3,  '2025-05-06', 4598.00, 'net_banking', 'success'),
    (4,  '2025-05-08', 598.00,  'upi',         'failed'),
    (5,  '2025-05-10', 4297.00, 'card',        'success'),
    (6,  '2025-05-12', 3798.00, 'upi',         'success'),
    (8,  '2025-05-16', 1897.00, 'wallet',      'success'),
    (9,  '2025-05-18', 3698.00, 'net_banking', 'success'),
    (10, '2025-05-20', 1799.00, 'card',        'refunded'),
    (11, '2025-05-22', 6898.00, 'upi',         'success'),
    (12, '2025-05-24', 2398.00, 'cash',        'success'),
    (13, '2025-05-26', 1699.00, 'card',        'success'),
    (14, '2025-05-28', 12499.00,'net_banking', 'success'),
    (16, '2025-06-02', 5798.00, 'upi',         'success'),
    (17, '2025-06-04', 3497.00, 'card',        'success'),
    (19, '2025-06-08', 2998.00, 'wallet',      'success'),
    (20, '2025-06-10', 9498.00, 'card',        'success'),
    (21, '2025-06-12', 1098.00, 'upi',         'success'),
    (22, '2025-06-14', 2097.00, 'net_banking', 'success'),
    (23, '2025-06-16', 3296.00, 'cash',        'success'),
    (24, '2025-06-18', 4598.00, 'upi',         'success');
