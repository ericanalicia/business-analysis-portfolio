# 🏭 Project 2 — Fashion Inventory Management System

## Overview

**Scenario:**
You are a Junior System Analyst at *StyleStock*, a fictional Australian fashion wholesaler that supplies clothing to boutiques across NSW and VIC. The operations manager complains that the team still tracks inventory in Excel spreadsheets — leading to stockouts, overordering, and lost sales.

**Your job:** Analyse the current process, design a simple inventory management system, build the database, and create a Power BI stock monitoring dashboard.

---

## 🎯 System Goals

1. Track how much stock is available for each product
2. Record every stock movement (received vs. sold)
3. Alert when stock falls below the reorder level
4. Show management a live inventory dashboard

---

### 1. Track how much stock is available for each product

```sql
WITH current_stock AS (
    SELECT product_id,
           SUM(
               CASE 
                   WHEN movement_type = 'received' THEN quantity
                   ELSE -quantity
               END
           ) AS stock_level
    FROM stock_movements
    GROUP BY product_id
)
SELECT p.product_name, p.category, cs.stock_level
FROM products p
JOIN current_stock cs ON p.product_id = cs.product_id
ORDER BY cs.stock_level DESC;
```

| product_name | category | stock_level |
|---|---|---|
| Gold Hoop Earrings | Accessories | 112 |
| Striped T-Shirt | Tops | 34 |
| Chunky Knit Cardigan | Tops | 28 |
| Floral Wrap Dress | Dresses | 27 |
| Wide Leg Trousers | Bottoms | 25 |
| High-Waist Jeans | Bottoms | 24 |
| Block Heel Sandals | Footwear | 11 |
| White Linen Shirt | Tops | 0 |
| Leather Tote Bag | Accessories | 0 |
| Slip-On Sneakers | Footwear | 0 |

**Insight:** Stock levels vary widely across the catalogue, from 112 units (Gold Hoop Earrings) down to 0 units for three products. This live stock view is the foundation the reorder alert system (see Goal 3) builds on top of.

---

### 2. Record every stock movement (received vs. sold)

```sql
SELECT p.product_name, sm.movement_type, sm.quantity, sm.movement_date
FROM stock_movements sm
JOIN products p ON sm.product_id = p.product_id
ORDER BY sm.movement_date DESC
LIMIT 10;
```

| product_name | movement_type | quantity | movement_date |
|---|---|---|---|
| Chunky Knit Cardigan | sold | 3 | 2024-06-28 |
| Striped T-Shirt | sold | 5 | 2024-06-27 |
| Wide Leg Trousers | sold | 4 | 2024-06-27 |
| Leather Tote Bag | sold | 2 | 2024-06-26 |
| Gold Hoop Earrings | sold | 7 | 2024-06-26 |
| Floral Wrap Dress | sold | 5 | 2024-06-23 |
| Wide Leg Trousers | sold | 5 | 2024-06-19 |
| Wide Leg Trousers | sold | 6 | 2024-06-18 |
| Floral Wrap Dress | sold | 5 | 2024-06-17 |
| Wide Leg Trousers | sold | 3 | 2024-06-13 |

**Insight:** Every stock movement is individually logged with product, type, quantity, and date — giving full traceability of inventory changes over time, rather than just a single "current stock" snapshot with no history (the exact problem the operations manager originally complained about).

---

### 3. Alert when stock falls below the reorder level

```sql
WITH current_stock AS (
    SELECT product_id,
           SUM(
               CASE 
                   WHEN movement_type = 'received' THEN quantity
                   ELSE -quantity
               END
           ) AS stock_level
    FROM stock_movements
    GROUP BY product_id
)
SELECT p.product_name, p.category, cs.stock_level, p.reorder_level,
       CASE 
           WHEN cs.stock_level < p.reorder_level THEN 'REORDER'
           ELSE 'OK'
       END AS status
FROM products p
JOIN current_stock cs ON p.product_id = cs.product_id
ORDER BY cs.stock_level ASC;
```

| product_name | category | stock_level | reorder_level | status |
|---|---|---|---|---|
| White Linen Shirt | Tops | 0 | 20 | REORDER |
| Leather Tote Bag | Accessories | 0 | 10 | REORDER |
| Slip-On Sneakers | Footwear | 0 | 12 | REORDER |
| Block Heel Sandals | Footwear | 11 | 12 | REORDER |
| High-Waist Jeans | Bottoms | 24 | 15 | OK |
| Wide Leg Trousers | Bottoms | 25 | 15 | OK |
| Floral Wrap Dress | Dresses | 27 | 15 | OK |
| Chunky Knit Cardigan | Tops | 28 | 15 | OK |
| Striped T-Shirt | Tops | 34 | 20 | OK |
| Gold Hoop Earrings | Accessories | 112 | 10 | OK |

**Insight:** 4 of 10 products (40%) are currently at or near their reorder threshold, with 3 products completely out of stock (White Linen Shirt, Leather Tote Bag, Slip-On Sneakers). This query could be run daily to automatically flag restocking needs before shelves go empty, directly addressing the operations manager's core complaint about stockouts.

---

### 4. Show management a live inventory dashboard

🔧 **Status: Planned, not yet built.** This goal requires a Power BI dashboard connected to the stock summary query from Goal 1 (live current-stock view) and the reorder alert query from Goal 3. Next step: connect this dataset to Power BI and build visual KPI cards for stock levels and reorder alerts.

---

## 📂 Folder Structure

```
project-02-inventory-system/
│
├── data/
│   └── inventory_data.csv         ← Sample dataset
│
├── sql/
│   ├── 01_create_tables.sql       ← Step 3: Design the database schema
│   ├── 02_insert_data.sql         ← Step 4: Populate with sample data
│   └── 03_inventory_queries.sql   ← Step 5: Query inventory status
│
├── powerbi/
│   └── INSTRUCTIONS.md            ← Step 6: Build the stock dashboard
│
├── system-design/
│   ├── process_flow.md            ← Step 1: Current vs future process
│   └── data_dictionary.md         ← Step 2: Define all data fields
│
└── docs/
    ├── system_requirements.md     ← Business & system requirements
    └── lessons_learned.md         ← Fill in after completing!
```

---

## 🛠️ Tools You'll Need

| Tool | Download Link | Cost |
|---|---|---|
| DB Browser for SQLite | https://sqlitebrowser.org/ | Free |
| Power BI Desktop | https://powerbi.microsoft.com/ | Free |
| Draw.io (for diagrams) | https://app.diagrams.net/ | Free |

---

## 💡 New Skills in This Project

Compared to Project 1, this project introduces:

- ✅ **Multi-table database design** (Products, Stock, Movements — linked by foreign keys)
- ✅ **JOIN queries** (combining data from multiple tables)
- ✅ **System requirements documentation**
