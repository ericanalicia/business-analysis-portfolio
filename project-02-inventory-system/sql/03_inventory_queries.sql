-- ============================================================
-- PROJECT 2: StyleStock Inventory Management System
-- Script 03: Inventory Analysis Queries
-- ============================================================
-- BEGINNER TIP:
-- This script uses JOIN — the most important SQL concept for
-- working with multiple tables. A JOIN combines rows from two
-- tables based on a matching column (usually a foreign key).
--
-- Types of JOIN used here:
--   INNER JOIN = only rows that match in BOTH tables
--   LEFT JOIN  = all rows from left table, matching rows from right
-- ============================================================


-- ============================================================
-- QUERY 1: Full inventory status (JOIN across 3 tables)
-- ============================================================
-- CONCEPTS USED: INNER JOIN, CASE, comparison operators

SELECT
    p.product_id,
    p.product_name,
    p.category,
    p.gender,
    sl.current_qty,
    p.reorder_level,
    CASE
        WHEN sl.current_qty <= p.reorder_level THEN '🔴 REORDER NOW'
        WHEN sl.current_qty <= p.reorder_level * 1.5 THEN '🟡 LOW STOCK'
        ELSE '🟢 OK'
    END AS stock_status,
    p.reorder_qty,
    ROUND(sl.current_qty * p.cost_price, 2) AS stock_value_at_cost
FROM products p
INNER JOIN stock_levels sl ON p.product_id = sl.product_id
WHERE p.is_active = 1
ORDER BY sl.current_qty ASC;

-- 💡 WHAT TO LOOK FOR:
-- Which products have 🔴 REORDER NOW status?
-- These should be ordered from the supplier immediately!


-- ============================================================
-- QUERY 2: Total inventory value by category
-- ============================================================
-- CONCEPTS USED: INNER JOIN, GROUP BY, SUM, ROUND

SELECT
    p.category,
    COUNT(p.product_id)                           AS product_count,
    SUM(sl.current_qty)                           AS total_units,
    ROUND(SUM(sl.current_qty * p.cost_price), 2)  AS total_value_at_cost,
    ROUND(SUM(sl.current_qty * p.sell_price), 2)  AS potential_revenue
FROM products p
INNER JOIN stock_levels sl ON p.product_id = sl.product_id
WHERE p.is_active = 1
GROUP BY p.category
ORDER BY total_value_at_cost DESC;

-- 💡 WHAT TO LOOK FOR:
-- Which category has the most capital tied up in stock?
-- What is the total potential revenue if all stock is sold?


-- ============================================================
-- QUERY 3: Products that need reordering (reorder report)
-- ============================================================
-- This is what the buying team would use every morning!

SELECT
    p.product_id,
    p.product_name,
    p.category,
    sl.current_qty                      AS current_stock,
    p.reorder_level                     AS reorder_at,
    p.reorder_qty                       AS order_quantity,
    s.supplier_name,
    s.lead_time_days,
    ROUND(p.reorder_qty * p.cost_price, 2) AS estimated_order_cost
FROM products p
INNER JOIN stock_levels sl ON p.product_id = sl.product_id
INNER JOIN suppliers s ON p.supplier_id = s.supplier_id
WHERE sl.current_qty <= p.reorder_level
  AND p.is_active = 1
ORDER BY sl.current_qty ASC;

-- 💡 WHAT TO LOOK FOR:
-- How many products need reordering?
-- What is the total estimated cost to restock?


-- ============================================================
-- QUERY 4: Stock movement history for a specific product
-- ============================================================
-- Change 'P001' to any product_id to see its movement history

SELECT
    sm.movement_id,
    sm.movement_date,
    sm.movement_type,
    sm.quantity,
    CASE sm.movement_type
        WHEN 'IN'  THEN '+' || sm.quantity
        WHEN 'OUT' THEN '-' || sm.quantity
    END AS change,
    sm.reference,
    sm.notes
FROM stock_movements sm
WHERE sm.product_id = 'P001'
ORDER BY sm.movement_date ASC;

-- 💡 WHAT TO LOOK FOR:
-- You can see the full story of how stock moved for this product.
-- This is the audit trail that businesses need for accounting.


-- ============================================================
-- QUERY 5: Running stock balance per product (advanced!)
-- ============================================================
-- CONCEPTS USED: SUM with CASE, GROUP BY
-- This calculates total IN vs total OUT to verify current stock

SELECT
    p.product_name,
    SUM(CASE WHEN sm.movement_type = 'IN'  THEN sm.quantity ELSE 0 END) AS total_received,
    SUM(CASE WHEN sm.movement_type = 'OUT' THEN sm.quantity ELSE 0 END) AS total_dispatched,
    SUM(CASE WHEN sm.movement_type = 'IN'  THEN sm.quantity ELSE 0 END) -
    SUM(CASE WHEN sm.movement_type = 'OUT' THEN sm.quantity ELSE 0 END) AS calculated_stock,
    sl.current_qty AS recorded_stock,
    CASE
        WHEN (
            SUM(CASE WHEN sm.movement_type = 'IN'  THEN sm.quantity ELSE 0 END) -
            SUM(CASE WHEN sm.movement_type = 'OUT' THEN sm.quantity ELSE 0 END)
        ) = sl.current_qty THEN '✅ Match'
        ELSE '⚠️ Discrepancy!'
    END AS reconciliation
FROM stock_movements sm
INNER JOIN products p  ON sm.product_id = p.product_id
INNER JOIN stock_levels sl ON sm.product_id = sl.product_id
GROUP BY sm.product_id, p.product_name, sl.current_qty;

-- 💡 WHAT TO LEARN:
-- This query is stock reconciliation — checking that movements
-- add up to the recorded stock level. Auditors love this!


-- ============================================================
-- QUERY 6: Supplier performance summary
-- ============================================================

SELECT
    s.supplier_name,
    s.country,
    s.lead_time_days,
    COUNT(DISTINCT p.product_id) AS products_supplied,
    SUM(CASE WHEN sm.movement_type = 'IN' THEN sm.quantity ELSE 0 END) AS total_units_received,
    ROUND(SUM(CASE WHEN sm.movement_type = 'IN' THEN sm.quantity * p.cost_price ELSE 0 END), 2) AS total_spend_aud
FROM suppliers s
LEFT JOIN products p ON s.supplier_id = p.supplier_id
LEFT JOIN stock_movements sm ON p.product_id = sm.product_id
GROUP BY s.supplier_id, s.supplier_name, s.country, s.lead_time_days
ORDER BY total_spend_aud DESC;
