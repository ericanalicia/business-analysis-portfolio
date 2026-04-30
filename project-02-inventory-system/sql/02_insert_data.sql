-- ============================================================
-- PROJECT 2: StyleStock Inventory Management System
-- Script 02: Insert Sample Data
-- ============================================================
-- BEGINNER TIP:
-- We insert data in the correct order:
--   1. suppliers (no dependencies)
--   2. products (depends on suppliers)
--   3. stock_levels (depends on products)
--   4. stock_movements (depends on products)
--
-- If you insert in wrong order, the FOREIGN KEY constraint
-- will throw an error — this is how the database protects itself!
-- ============================================================

-- --------------------------------------------------------
-- INSERT: Suppliers
-- --------------------------------------------------------
INSERT INTO suppliers VALUES ('S001', 'AusFashion Wholesale', 'orders@ausfashion.com.au', 'Australia', 10);
INSERT INTO suppliers VALUES ('S002', 'Pacific Style Co.', 'supply@pacificstyle.com.au', 'Australia', 14);
INSERT INTO suppliers VALUES ('S003', 'Shanghai Textiles Ltd', 'sales@shanghaitextiles.cn', 'China', 35);
INSERT INTO suppliers VALUES ('S004', 'Melbourne Denim Co.', 'hello@melbdenim.com.au', 'Australia', 7);

-- --------------------------------------------------------
-- INSERT: Products (10 fashion items)
-- --------------------------------------------------------
INSERT INTO products VALUES ('P001', 'Floral Wrap Dress',     'Dresses',      'Women',  'S001', 35.00,  89.99,  15, 40, 1);
INSERT INTO products VALUES ('P002', 'White Linen Shirt',     'Tops',         'Women',  'S001', 18.00,  49.99,  25, 60, 1);
INSERT INTO products VALUES ('P003', 'High-Waist Jeans',      'Bottoms',      'Women',  'S004', 28.00,  79.99,  20, 50, 1);
INSERT INTO products VALUES ('P004', 'Leather Tote Bag',      'Accessories',  'Women',  'S002', 45.00, 129.99,  10, 25, 1);
INSERT INTO products VALUES ('P005', 'Block Heel Sandals',    'Footwear',     'Women',  'S003', 38.00,  99.99,  15, 30, 1);
INSERT INTO products VALUES ('P006', 'Striped T-Shirt',       'Tops',         'Unisex', 'S001', 10.00,  29.99,  30, 80, 1);
INSERT INTO products VALUES ('P007', 'Wide Leg Trousers',     'Bottoms',      'Women',  'S002', 25.00,  69.99,  20, 50, 1);
INSERT INTO products VALUES ('P008', 'Gold Hoop Earrings',    'Accessories',  'Women',  'S002', 8.00,   24.99,  40, 100, 1);
INSERT INTO products VALUES ('P009', 'Slip-On Sneakers',      'Footwear',     'Unisex', 'S003', 30.00,  79.99,  15, 40, 1);
INSERT INTO products VALUES ('P010', 'Chunky Knit Cardigan',  'Tops',         'Women',  'S001', 22.00,  59.99,  20, 50, 1);

-- --------------------------------------------------------
-- INSERT: Stock Levels (starting inventory)
-- Some products are already low to demonstrate reorder alerts!
-- --------------------------------------------------------
INSERT INTO stock_levels VALUES ('P001', 12,  '2024-06-30');  -- ⚠️ BELOW reorder level (15)
INSERT INTO stock_levels VALUES ('P002', 45,  '2024-06-30');
INSERT INTO stock_levels VALUES ('P003', 18,  '2024-06-30');  -- ⚠️ BELOW reorder level (20)
INSERT INTO stock_levels VALUES ('P004', 8,   '2024-06-30');  -- ⚠️ BELOW reorder level (10)
INSERT INTO stock_levels VALUES ('P005', 22,  '2024-06-30');
INSERT INTO stock_levels VALUES ('P006', 63,  '2024-06-30');
INSERT INTO stock_levels VALUES ('P007', 31,  '2024-06-30');
INSERT INTO stock_levels VALUES ('P008', 95,  '2024-06-30');
INSERT INTO stock_levels VALUES ('P009', 14,  '2024-06-30');  -- ⚠️ BELOW reorder level (15)
INSERT INTO stock_levels VALUES ('P010', 27,  '2024-06-30');

-- --------------------------------------------------------
-- INSERT: Stock Movements (history of stock in/out)
-- --------------------------------------------------------
-- January stock receipts (IN)
INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date, reference, notes)
VALUES ('P001', 'IN', 50, '2024-01-05', 'PO-2024-001', 'Autumn collection delivery');
INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date, reference, notes)
VALUES ('P002', 'IN', 80, '2024-01-05', 'PO-2024-001', 'Autumn collection delivery');
INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date, reference, notes)
VALUES ('P003', 'IN', 60, '2024-01-05', 'PO-2024-002', 'Denim restock');
INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date, reference, notes)
VALUES ('P006', 'IN', 100, '2024-01-08', 'PO-2024-003', 'Basics restock');

-- February dispatches (OUT — sold to boutiques)
INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date, reference, notes)
VALUES ('P001', 'OUT', 12, '2024-02-10', 'SO-2024-101', 'Sydney boutique order');
INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date, reference, notes)
VALUES ('P002', 'OUT', 15, '2024-02-10', 'SO-2024-101', 'Sydney boutique order');
INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date, reference, notes)
VALUES ('P006', 'OUT', 20, '2024-02-12', 'SO-2024-102', 'Melbourne boutique order');

-- March stock receipts
INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date, reference, notes)
VALUES ('P004', 'IN', 30, '2024-03-01', 'PO-2024-010', 'Accessories restock');
INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date, reference, notes)
VALUES ('P005', 'IN', 40, '2024-03-01', 'PO-2024-011', 'Footwear delivery');
INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date, reference, notes)
VALUES ('P009', 'IN', 40, '2024-03-01', 'PO-2024-011', 'Footwear delivery');

-- April dispatches
INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date, reference, notes)
VALUES ('P001', 'OUT', 18, '2024-04-05', 'SO-2024-201', 'Brisbane boutique order');
INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date, reference, notes)
VALUES ('P003', 'OUT', 22, '2024-04-05', 'SO-2024-201', 'Brisbane boutique order');
INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date, reference, notes)
VALUES ('P004', 'OUT', 16, '2024-04-08', 'SO-2024-202', 'Perth boutique order');
INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date, reference, notes)
VALUES ('P008', 'OUT', 25, '2024-04-08', 'SO-2024-202', 'Perth boutique order');

-- May stock receipts and dispatches
INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date, reference, notes)
VALUES ('P007', 'IN', 60, '2024-05-03', 'PO-2024-020', 'Winter collection');
INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date, reference, notes)
VALUES ('P010', 'IN', 70, '2024-05-03', 'PO-2024-020', 'Winter collection');
INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date, reference, notes)
VALUES ('P002', 'OUT', 20, '2024-05-15', 'SO-2024-301', 'Online partner order');
INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date, reference, notes)
VALUES ('P006', 'OUT', 17, '2024-05-15', 'SO-2024-301', 'Online partner order');

-- June dispatches (EOFY period)
INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date, reference, notes)
VALUES ('P001', 'OUT', 8, '2024-06-20', 'SO-2024-401', 'EOFY sale dispatch');
INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date, reference, notes)
VALUES ('P005', 'OUT', 18, '2024-06-20', 'SO-2024-401', 'EOFY sale dispatch');
INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date, reference, notes)
VALUES ('P009', 'OUT', 26, '2024-06-25', 'SO-2024-402', 'EOFY clearance');
INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date, reference, notes)
VALUES ('P003', 'OUT', 20, '2024-06-28', 'SO-2024-403', 'End of season clearance');
INSERT INTO stock_movements (product_id, movement_type, quantity, movement_date, reference, notes)
VALUES ('P010', 'OUT', 43, '2024-06-30', 'SO-2024-404', 'End of season clearance');

-- Verify data was inserted
SELECT 'suppliers' AS table_name, COUNT(*) AS row_count FROM suppliers UNION ALL
SELECT 'products',     COUNT(*) FROM products UNION ALL
SELECT 'stock_levels', COUNT(*) FROM stock_levels UNION ALL
SELECT 'stock_movements', COUNT(*) FROM stock_movements;
