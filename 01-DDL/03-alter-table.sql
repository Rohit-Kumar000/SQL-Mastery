-- ----------------------------------------------------------------------------
-- ALTER TABLE 
-- ----------------------------------------------------------------------------

-- Add a column:
ALTER TABLE products ADD COLUMN product_description TEXT;

-- Change a column's data type:
ALTER TABLE products ALTER COLUMN product_name TYPE VARCHAR(150);
ALTER TABLE products ALTER COLUMN product_name TYPE VARCHAR(100);  -- restore the original size

-- Set / remove a default:
ALTER TABLE products ALTER COLUMN stock_quantity SET DEFAULT 10;
ALTER TABLE products ALTER COLUMN stock_quantity DROP DEFAULT;
ALTER TABLE products ALTER COLUMN stock_quantity SET DEFAULT 0;   -- restore the original default

-- Rename a column:
ALTER TABLE customers RENAME COLUMN phone TO mobile_number;
ALTER TABLE customers RENAME COLUMN mobile_number TO phone;       -- rename back (later scripts use "phone")

-- Add a constraint:
ALTER TABLE products ADD CONSTRAINT chk_product_price CHECK (price > 0);

-- Remove a constraint (use the actual constraint name):
ALTER TABLE products DROP CONSTRAINT chk_product_price;

-- Drop a column (destructive):
ALTER TABLE products DROP COLUMN product_description;

-- Rename a table:
ALTER TABLE products RENAME TO store_products;
ALTER TABLE store_products RENAME TO products;
