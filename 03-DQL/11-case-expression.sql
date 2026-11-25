-- ----------------------------------------------------------------------------
-- 14. CASE EXPRESSION (CASE WHEN)
-- ----------------------------------------------------------------------------

-- Searched CASE: label the stock level of every product
SELECT
    product_name,
    stock_quantity,
    CASE
        WHEN stock_quantity = 0  THEN 'Out of stock'
        WHEN stock_quantity < 20 THEN 'Low stock'
        WHEN stock_quantity < 60 THEN 'Medium stock'
        ELSE 'Well stocked'
    END AS stock_status
FROM products
ORDER BY stock_quantity;

-- Price bands (Budget / Mid-range / Premium)
SELECT
    product_name,
    price,
    CASE
        WHEN price < 1000 THEN 'Budget'
        WHEN price BETWEEN 1000 AND 3000 THEN 'Mid-range'
        ELSE 'Premium'
    END AS price_band
FROM products
ORDER BY price;

-- Simple CASE: compare one column against fixed values
SELECT
    order_id,
    status,
    CASE status
        WHEN 'completed'  THEN 'Delivered'
        WHEN 'processing' THEN 'Being packed'
        WHEN 'pending'    THEN 'Awaiting confirmation'
        WHEN 'cancelled'  THEN 'Cancelled by customer'
        ELSE 'Other'
    END AS order_stage
FROM orders;

-- Customer loyalty tiers
SELECT
    first_name,
    last_name,
    loyalty_points,
    CASE
        WHEN loyalty_points >= 400 THEN 'Gold'
        WHEN loyalty_points >= 200 THEN 'Silver'
        WHEN loyalty_points >= 100 THEN 'Bronze'
        ELSE 'Basic'
    END AS loyalty_tier
FROM customers
ORDER BY loyalty_points DESC;

-- CASE inside ORDER BY: custom sort order (pending first, then processing...)
SELECT order_id, status, order_date
FROM orders
ORDER BY
    CASE status
        WHEN 'pending'    THEN 1
        WHEN 'processing' THEN 2
        WHEN 'completed'  THEN 3
        ELSE 4
    END,
    order_id;

-- Conditional aggregation: count orders by status in a single row
SELECT
    COUNT(*) AS total_orders,
    SUM(CASE WHEN status = 'completed'  THEN 1 ELSE 0 END) AS completed_orders,
    SUM(CASE WHEN status = 'pending'    THEN 1 ELSE 0 END) AS pending_orders,
    SUM(CASE WHEN status = 'cancelled'  THEN 1 ELSE 0 END) AS cancelled_orders
FROM orders;

-- PostgreSQL shortcut for conditional aggregation: FILTER
SELECT
    COUNT(*) FILTER (WHERE status = 'completed') AS completed_orders,
    COUNT(*) FILTER (WHERE status = 'pending')   AS pending_orders,
    COUNT(*) FILTER (WHERE status = 'cancelled') AS cancelled_orders
FROM orders;

-- Conditional aggregation per payment method
SELECT
    payment_method,
    SUM(CASE WHEN status = 'success' THEN amount ELSE 0 END) AS successful_amount,
    SUM(CASE WHEN status = 'failed'  THEN amount ELSE 0 END) AS failed_amount
FROM payments
GROUP BY payment_method
ORDER BY payment_method;
