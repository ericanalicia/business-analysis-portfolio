-- ============================================================
-- PROJECT 2: StyleStock Inventory Management System
-- Script 01: Create Tables
-- ============================================================
-- BEGINNER TIP:
-- This script creates FOUR tables that are linked to each other.
-- This is called a "relational database" — the key difference
-- from Project 1 where we had just one table.
--
-- FOREIGN KEY = a column in one table that points to another table.
-- Example: products.supplier_id references suppliers.supplier_id
-- ============================================================

-- --------------------------------------------------------
-- Drop tables in correct order (child tables first)
-- --------------------------------------------------------
DROP TABLE IF EXISTS stock_movements;
DROP TABLE IF EXISTS stock_levels;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS suppliers;

-- --------------------------------------------------------
-- Table 1: suppliers
-- The "parent" table — referenced by products
-- --------------------------------------------------------
CREATE TABLE suppliers (
    supplier_id    TEXT PRIMARY KEY,
    supplier_name  TEXT NOT NULL,
    contact_email  TEXT,
    country        TEXT NOT NULL DEFAULT 'Australia',
    lead_time_days INTEGER NOT NULL DEFAULT 14
);

-- --------------------------------------------------------
-- Table 2: products
-- References suppliers via supplier_id (foreign key)
-- --------------------------------------------------------
CREATE TABLE products (
    product_id    TEXT PRIMARY KEY,
    product_name  TEXT NOT NULL,
    category      TEXT NOT NULL,
    gender        TEXT NOT NULL CHECK (gender IN ('Women', 'Men', 'Unisex')),
    supplier_id   TEXT NOT NULL,
    cost_price    REAL NOT NULL,
    sell_price    REAL NOT NULL,
    reorder_level INTEGER NOT NULL DEFAULT 20,
    reorder_qty   INTEGER NOT NULL DEFAULT 50,
    is_active     INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- --------------------------------------------------------
-- Table 3: stock_levels
-- One row per product — current inventory quantity
-- --------------------------------------------------------
CREATE TABLE stock_levels (
    product_id    TEXT PRIMARY KEY,
    current_qty   INTEGER NOT NULL DEFAULT 0,
    last_updated  TEXT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- --------------------------------------------------------
-- Table 4: stock_movements
-- Audit log — every IN and OUT movement recorded here
-- --------------------------------------------------------
CREATE TABLE stock_movements (
    movement_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    product_id    TEXT NOT NULL,
    movement_type TEXT NOT NULL CHECK (movement_type IN ('IN', 'OUT')),
    quantity      INTEGER NOT NULL CHECK (quantity > 0),
    movement_date TEXT NOT NULL,
    reference     TEXT,
    notes         TEXT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- --------------------------------------------------------
-- Verify all 4 tables were created
-- --------------------------------------------------------
SELECT name, type FROM sqlite_master
WHERE type = 'table'
ORDER BY name;
