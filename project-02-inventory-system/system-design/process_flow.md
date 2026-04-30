# Process Flow — Inventory Management
## StyleStock: As-Is vs To-Be Process

---

## 🔴 AS-IS Process (Current State — What's Broken)

This is how the team currently manages inventory **before** our system is built.

```
┌─────────────────────────────────────────────────────────────────────┐
│                    CURRENT INVENTORY PROCESS                        │
│                    (Manual / Excel-based)                           │
└─────────────────────────────────────────────────────────────────────┘

Stock Arrives from Supplier
         │
         ▼
Warehouse staff manually updates Excel spreadsheet
         │
         ├──► ⚠️  RISK: Wrong product code entered
         ├──► ⚠️  RISK: Two people edit at the same time → overwrite
         │
         ▼
Manager checks spreadsheet to see current stock levels
         │
         ├──► ⚠️  RISK: Spreadsheet may be outdated
         ├──► ⚠️  RISK: No automatic reorder alert
         │
         ▼
Manager manually identifies low-stock items
         │
         ├──► ⚠️  RISK: Missed items → stockout → lost sales
         │
         ▼
Manager emails supplier to reorder
         │
         ├──► ⚠️  RISK: No tracking of what was ordered
         │
         ▼
Sales Team records outgoing stock in a separate spreadsheet
         │
         ├──► ⚠️  RISK: Two spreadsheets get out of sync
         │
         ▼
Finance manually calculates inventory value each month
         │
         └──► ⚠️  RISK: Time-consuming and error-prone
```

**Problems Summary:**
- No single source of truth
- No automated alerts
- High risk of human error
- No audit trail of stock movements
- Finance reporting is slow and manual

---

## 🟢 TO-BE Process (Future State — Our System)

This is how inventory will work **after** our database + Power BI system is built.

```
┌─────────────────────────────────────────────────────────────────────┐
│                    NEW INVENTORY PROCESS                            │
│                    (Database + Power BI)                            │
└─────────────────────────────────────────────────────────────────────┘

Stock Arrives from Supplier
         │
         ▼
Warehouse staff logs stock receipt in the system
  → INSERT INTO stock_movements (product_id, type='IN', quantity, date)
         │
         ▼
Database automatically updates current stock level
  → stock_levels table updated via calculation
         │
         ├──► ✅ Audit trail: every movement is recorded with timestamp
         │
         ▼
Power BI Dashboard refreshes daily
         │
         ├──► ✅ Operations Manager sees current stock levels
         ├──► ✅ RED ALERT shown for products below reorder level
         ├──► ✅ Finance sees live inventory valuation
         │
         ▼
Sales Team logs outgoing stock
  → INSERT INTO stock_movements (product_id, type='OUT', quantity, date)
         │
         ▼
Stock level automatically decreases
         │
         └──► ✅ Single source of truth — no separate spreadsheets
```

**Improvements Summary:**

| Problem (As-Is) | Solution (To-Be) |
|---|---|
| Multiple Excel files | Single SQL database |
| No reorder alerts | Power BI highlights items below reorder level |
| Manual stock counting | Database tracks every movement |
| No audit trail | All movements recorded with date and type |
| Slow financial reporting | Instant inventory valuation query |

---

## ✏️ Learning Note

Mapping **As-Is vs To-Be** processes is one of the most important skills of a System Analyst. Before building anything, you need to clearly understand:

1. **What is happening now** (As-Is) — even if it's messy
2. **What should happen in future** (To-Be) — your proposed improvement
3. **The gap between them** — this is what you're being paid to close

In Australia, tools like **Lucidchart**, **draw.io**, and **Microsoft Visio** are commonly used to draw these process flows visually. The text version above can be turned into a diagram using [draw.io](https://app.diagrams.net/) for free!
