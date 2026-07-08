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

## 🪜 Step-by-Step Learning Guide

### ✅ Step 1 — Understand the Current Process
Read `system-design/process_flow.md`. A System Analyst always maps the **As-Is** (current) process before designing the **To-Be** (future) system.

### ✅ Step 2 — Read the Data Dictionary
Open `system-design/data_dictionary.md`. This defines every field in the system — understanding your data structure is fundamental to system analysis.

### ✅ Step 3 — Design the Database
Run `sql/01_create_tables.sql`. This creates a **multi-table** database (more advanced than Project 1!) — you'll learn about table relationships.

### ✅ Step 4 — Load Sample Data
Run `sql/02_insert_data.sql` to populate all tables with realistic fashion inventory data.

### ✅ Step 5 — Query Inventory Status
Open `sql/03_inventory_queries.sql`. These queries simulate what a real inventory system would need to know.

### ✅ Step 6 — Build the Stock Dashboard
Follow `powerbi/INSTRUCTIONS.md` to build a dashboard that monitors live stock levels.

### ✅ Step 7 — Document Lessons Learned
Fill in `docs/lessons_learned.md`. In real workplaces, analysts always document what they built and why.

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
- ✅ **Process flow mapping** (As-Is vs To-Be)
- ✅ **Data dictionary writing**
- ✅ **Stock KPIs** in Power BI (reorder alerts, stock value)
