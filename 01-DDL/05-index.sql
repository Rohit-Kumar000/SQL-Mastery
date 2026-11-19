-- ----------------------------------------------------------------------------
-- INDEXES
-- ----------------------------------------------------------------------------
CREATE INDEX idx_products_category_id ON products(category_id);
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_orders_order_date ON orders(order_date);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);

-- Unique constraints already create indexes for emails and category_name.
-- Example of an additional index:
CREATE INDEX idx_customers_city ON customers(city);
DROP INDEX idx_customers_city;

-- DDL END
