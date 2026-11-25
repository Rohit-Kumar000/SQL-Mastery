-- ----------------------------------------------------------------------------
-- 19. ADVANCED WINDOW FUNCTIONS
-- ----------------------------------------------------------------------------

-- Running total of completed order values
WITH order_totals AS (
    SELECT
        o.order_id,
        o.order_date,
        SUM(oi.quantity * oi.unit_price) AS order_total
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.status = 'completed'
    GROUP BY o.order_id, o.order_date
)
SELECT
    order_id,
    order_date,
    order_total,
    SUM(order_total) OVER (ORDER BY order_date, order_id) AS running_total
FROM order_totals
ORDER BY order_date, order_id;

-- LAG and LEAD: compare each order with the previous and next order
WITH order_totals AS (
    SELECT
        o.order_id,
        o.order_date,
        SUM(oi.quantity * oi.unit_price) AS order_total
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.status = 'completed'
    GROUP BY o.order_id, o.order_date
)
SELECT
    order_id,
    order_date,
    order_total,
    LAG(order_total)  OVER (ORDER BY order_date, order_id) AS previous_order_total,
    LEAD(order_total) OVER (ORDER BY order_date, order_id) AS next_order_total,
    order_total - LAG(order_total) OVER (ORDER BY order_date, order_id) AS change_from_previous
FROM order_totals
ORDER BY order_date, order_id;

-- LAG with PARTITION BY: days between a customer's consecutive orders
SELECT
    customer_id,
    order_id,
    order_date,
    LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date, order_id) AS previous_order_date,
    order_date - LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date, order_id) AS days_since_previous_order
FROM orders
ORDER BY customer_id, order_date, order_id;

-- NTILE: split products into 4 price groups (quartiles)
SELECT
    product_name,
    price,
    NTILE(4) OVER (ORDER BY price) AS price_quartile
FROM products
ORDER BY price;

-- FIRST_VALUE and LAST_VALUE: cheapest and costliest product of each category
-- (LAST_VALUE needs an explicit frame, otherwise it stops at the current row)
SELECT
    category_id,
    product_name,
    price,
    FIRST_VALUE(product_name) OVER (
        PARTITION BY category_id ORDER BY price
    ) AS cheapest_product,
    LAST_VALUE(product_name) OVER (
        PARTITION BY category_id ORDER BY price
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS costliest_product
FROM products
ORDER BY category_id, price;

-- Frame clause: moving average of the last 3 orders (current + 2 before)
WITH order_totals AS (
    SELECT
        o.order_id,
        o.order_date,
        SUM(oi.quantity * oi.unit_price) AS order_total
    FROM orders o
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.status = 'completed'
    GROUP BY o.order_id, o.order_date
)
SELECT
    order_id,
    order_date,
    order_total,
    ROUND(AVG(order_total) OVER (
        ORDER BY order_date, order_id
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS moving_avg_3_orders
FROM order_totals
ORDER BY order_date, order_id;

-- PERCENT_RANK and CUME_DIST: where does each product stand by price?
SELECT
    product_name,
    price,
    ROUND(CAST(PERCENT_RANK() OVER (ORDER BY price) AS NUMERIC), 2) AS price_percent_rank,
    ROUND(CAST(CUME_DIST()    OVER (ORDER BY price) AS NUMERIC), 2) AS price_cum_dist
FROM products
ORDER BY price;

-- Top 2 most expensive products in every category
WITH ranked_products AS (
    SELECT
        category_id,
        product_name,
        price,
        ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY price DESC) AS price_rank
    FROM products
)
SELECT category_id, product_name, price, price_rank
FROM ranked_products
WHERE price_rank <= 2
ORDER BY category_id, price_rank;

-- Each category's share of total completed sales
SELECT
    c.category_name,
    SUM(oi.quantity * oi.unit_price) AS category_sales,
    ROUND(
        100.0 * SUM(oi.quantity * oi.unit_price)
        / SUM(SUM(oi.quantity * oi.unit_price)) OVER (),
        2
    ) AS sales_percentage
FROM categories c
JOIN products p      ON p.category_id = c.category_id
JOIN order_items oi  ON oi.product_id = p.product_id
JOIN orders o        ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY c.category_name
ORDER BY category_sales DESC;

-- Named window: define the window once and reuse it
SELECT
    product_name,
    category_id,
    price,
    RANK()       OVER category_window AS price_rank,
    SUM(price)   OVER category_window AS running_category_price
FROM products
WINDOW category_window AS (PARTITION BY category_id ORDER BY price DESC)
ORDER BY category_id, price DESC;
