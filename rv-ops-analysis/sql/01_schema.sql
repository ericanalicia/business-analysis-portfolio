-- ============================================================
-- Rebecca Vallance AW24 — Operations Analysis
-- Script 01: Schema
-- ============================================================

DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS products;

-- Product master: 15 SKUs across RTW, Swim, Accessories, Evening
CREATE TABLE products (
    sku_id          TEXT PRIMARY KEY,
    product_name    TEXT NOT NULL,
    category        TEXT NOT NULL,
    colour          TEXT NOT NULL,
    season          TEXT NOT NULL,
    rrp_aud         REAL NOT NULL,
    cost_aud        REAL NOT NULL,
    initial_stock   INTEGER NOT NULL   -- total units bought into the season
);

-- Sales transactions: Jan–Mar 2024 (weeks 1–11 of AW24)
CREATE TABLE sales (
    transaction_id  INTEGER PRIMARY KEY,
    date            TEXT NOT NULL,
    store           TEXT NOT NULL,     -- Sydney | Melbourne | Online
    sku_id          TEXT NOT NULL,
    product_name    TEXT NOT NULL,
    category        TEXT NOT NULL,
    quantity_sold   INTEGER NOT NULL,
    sell_price_aud  REAL NOT NULL,
    cost_price_aud  REAL NOT NULL,
    FOREIGN KEY (sku_id) REFERENCES products(sku_id)
);

-- Verify
SELECT name FROM sqlite_master WHERE type = 'table';
