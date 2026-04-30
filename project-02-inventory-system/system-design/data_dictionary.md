# Data Dictionary
## StyleStock — Inventory Management System

---

> **What is a Data Dictionary?**
> A data dictionary defines every field in your database — its name, data type, meaning, and rules. It is the "single source of truth" for your data structure. Every System Analyst should be able to write one.

---

## Table 1: `products`

Stores the master list of all products sold by StyleStock.

| Column Name | Data Type | Nullable | Description | Example |
|---|---|---|---|---|
| `product_id` | TEXT | No | Unique identifier for each product | P001 |
| `product_name` | TEXT | No | Full product name | Floral Wrap Dress |
| `category` | TEXT | No | Product category | Dresses |
| `gender` | TEXT | No | Target gender | Women, Men, Unisex |
| `supplier_id` | TEXT | No | FK → suppliers table | S001 |
| `cost_price` | REAL | No | What we pay the supplier (AUD) | 35.00 |
| `sell_price` | REAL | No | What we charge boutiques (AUD) | 89.99 |
| `reorder_level` | INTEGER | No | Minimum stock before reorder alert | 20 |
| `reorder_qty` | INTEGER | No | How many units to order when restocking | 50 |
| `is_active` | INTEGER | No | 1 = active, 0 = discontinued | 1 |

---

## Table 2: `suppliers`

Stores information about the suppliers StyleStock buys from.

| Column Name | Data Type | Nullable | Description | Example |
|---|---|---|---|---|
| `supplier_id` | TEXT | No | Unique identifier for each supplier | S001 |
| `supplier_name` | TEXT | No | Business name | AusFashion Wholesale |
| `contact_email` | TEXT | Yes | Supplier contact email | orders@ausfashion.com.au |
| `country` | TEXT | No | Country of manufacture | Australia |
| `lead_time_days` | INTEGER | No | Days from order to delivery | 14 |

---

## Table 3: `stock_levels`

Stores the **current** stock quantity for each product. Updated whenever a stock movement is recorded.

| Column Name | Data Type | Nullable | Description | Example |
|---|---|---|---|---|
| `product_id` | TEXT | No | FK → products table | P001 |
| `current_qty` | INTEGER | No | Units currently in warehouse | 45 |
| `last_updated` | TEXT | No | Date stock level was last changed | 2024-06-15 |

---

## Table 4: `stock_movements`

An **audit log** of every stock change — items received from suppliers (IN) or dispatched to boutiques (OUT).

| Column Name | Data Type | Nullable | Description | Example |
|---|---|---|---|---|
| `movement_id` | INTEGER | No | Auto-incrementing unique ID | 1001 |
| `product_id` | TEXT | No | FK → products table | P001 |
| `movement_type` | TEXT | No | 'IN' (received) or 'OUT' (dispatched) | IN |
| `quantity` | INTEGER | No | Number of units moved | 50 |
| `movement_date` | TEXT | No | Date of movement | 2024-01-10 |
| `reference` | TEXT | Yes | Purchase order or delivery note number | PO-2024-001 |
| `notes` | TEXT | Yes | Optional notes | Autumn collection delivery |

---

## Business Rules

> Business Rules define the logic that governs how data behaves. Every System Analyst must document these.

| Rule ID | Rule |
|---|---|
| BR-01 | `current_qty` in `stock_levels` must never go below 0 |
| BR-02 | A `movement_type` can only be 'IN' or 'OUT' |
| BR-03 | `quantity` in `stock_movements` must be greater than 0 |
| BR-04 | Every product in `stock_levels` must exist in `products` |
| BR-05 | Products with `is_active = 0` should not appear in reorder alerts |
| BR-06 | `reorder_level` is the threshold — if `current_qty` ≤ `reorder_level`, flag for reorder |

---

## Relationships (Entity Relationship Summary)

```
suppliers ──< products ──< stock_levels
                │
                └──< stock_movements
```

- One **supplier** can supply many **products** (1-to-many)
- One **product** has one **stock level** record (1-to-1)
- One **product** can have many **stock movements** (1-to-many)

---

## ✏️ Learning Note

A **Data Dictionary** shows employers that you understand not just how to query data, but how it's structured and governed. It demonstrates:
- Attention to detail
- Understanding of database relationships (foreign keys)
- Ability to communicate technical concepts clearly

This is a key deliverable asked for in **System Analyst** job descriptions across Australia.
