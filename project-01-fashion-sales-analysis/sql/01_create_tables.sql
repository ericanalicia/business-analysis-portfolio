-- ============================================================
-- PROJECT 1: TrendHive Fashion Retail — Sales Analysis
-- Script 01: Create Tables
-- ============================================================
-- BEGINNER TIP:
-- Before loading any data, we need to design our database table.
-- Think of a table like a spreadsheet with defined column types.
-- 
-- Common data types:
--   INTEGER  = whole numbers (1, 2, 100)
--   REAL     = decimal numbers (9.99, 129.50)
--   TEXT     = words/strings ("Sydney", "Dresses")
--   DATE     = date values (2024-01-05)
-- ============================================================

-- Drop the table if it already exists (useful when re-running the script)
DROP TABLE IF EXISTS sales;

-- Create the main sales table
CREATE TABLE sales (
    transaction_id   INTEGER PRIMARY KEY,   -- Unique ID for each sale
    sale_date        TEXT NOT NULL,         -- Date of the transaction
    store_location   TEXT NOT NULL,         -- City where the sale happened
    channel          TEXT NOT NULL,         -- 'In-Store' or 'Online'
    product_id       TEXT NOT NULL,         -- Internal product code
    product_name     TEXT NOT NULL,         -- Name of the product
    category         TEXT NOT NULL,         -- Product category (Dresses, Tops, etc.)
    quantity         INTEGER NOT NULL,      -- How many units sold
    unit_price       REAL NOT NULL,         -- Price per item
    total_amount     REAL NOT NULL,         -- quantity × unit_price
    customer_id      TEXT                   -- Customer identifier
);

-- ✅ Run this script first in DB Browser for SQLite
-- After running, you should see the 'sales' table in the left panel.

-- Verify the table was created
SELECT name FROM sqlite_master WHERE type='table';
