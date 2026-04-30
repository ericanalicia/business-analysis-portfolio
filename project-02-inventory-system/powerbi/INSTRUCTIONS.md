# Power BI Dashboard — Instructions
## StyleStock Inventory Monitoring Dashboard

---

## 🎯 Goal
Build a stock monitoring dashboard that helps the operations team see at a glance which products need reordering.

---

## 🛠️ Step-by-Step Instructions

### Step 1 — Export Data from SQLite

Run each query in DB Browser and export the results as CSV:

1. Run **Query 1** (Full inventory status) → Save as `inventory_status.csv`
2. Run **Query 2** (Value by category) → Save as `category_value.csv`
3. Run **Query 3** (Reorder report) → Save as `reorder_report.csv`

---

### Step 2 — Load Data into Power BI

1. Open **Power BI Desktop**
2. **Get Data > Text/CSV** → load `inventory_status.csv`
3. Repeat for the other two CSV files
4. You should now have 3 tables in your Fields panel

---

### Step 3 — Build Your Visuals

#### 📊 Visual 1 — Inventory Status Table
- **Visualisation:** Table
- **Columns:** `product_name`, `category`, `current_qty`, `reorder_level`, `stock_status`
- **Conditional Formatting:**
  - Select `stock_status` column
  - Click Format > Conditional Formatting > Background Colour
  - Set rules:
    - If value contains "REORDER" → Red background
    - If value contains "LOW" → Yellow background
    - If value contains "OK" → Green background
- **Title:** "Current Stock Status"

#### 📉 Visual 2 — Stock Level vs Reorder Level (Bar Chart)
- **Visualisation:** Clustered Bar Chart
- **Y-axis:** `product_name`
- **X-axis:** `current_qty` (blue bars)
- Add another series: `reorder_level` (red line or orange bars)
- **Title:** "Stock Level vs Reorder Point"
- **Tip:** This is called a "bullet chart" concept — where the red line shows the danger zone

#### 💰 Visual 3 — Inventory Value by Category (Donut Chart)
- **Visualisation:** Donut Chart
- **Values:** `stock_value_at_cost`
- **Legend:** `category`
- **Title:** "Inventory Value by Category (AUD)"

#### 🔴 Visual 4 — Reorder Alert Table
- **Visualisation:** Table
- **Data source:** `reorder_report.csv`
- **Columns:** `product_name`, `current_stock`, `order_quantity`, `supplier_name`, `lead_time_days`, `estimated_order_cost`
- Add a red banner background to this visual
- **Title:** "⚠️ Products Requiring Immediate Reorder"

#### 📦 Visual 5 — KPI Summary Cards (3 cards)
Using `inventory_status.csv`:
- **Card 1:** Total Products → `COUNT(product_id)`
- **Card 2:** Total Units in Stock → `SUM(current_qty)`
- **Card 3:** Total Stock Value → `SUM(stock_value_at_cost)` (format as AUD $)

---

### Step 4 — Add Slicers

Add two slicers so users can filter the dashboard:
1. **Slicer 1:** `category`
2. **Slicer 2:** `stock_status`

---

### Step 5 — Format the Dashboard

- Set page background to a very light grey (#F8F8F8)
- Add a title text box: **"StyleStock — Inventory Dashboard | June 2024"**
- Group the reorder alert section visually (use a red-bordered rectangle shape behind it)
- Add your name at the bottom: "Prepared by: Erica"

---

## 💡 DAX Measures (Optional — Advanced!)

Once you're comfortable with the basics, try creating these calculated measures:

```
// Total inventory value at cost
Total Cost Value = SUMX('inventory_status', 'inventory_status'[current_qty] * 'inventory_status'[cost_price])

// Count of products below reorder level
Products to Reorder = COUNTROWS(FILTER('inventory_status', 'inventory_status'[current_qty] <= 'inventory_status'[reorder_level]))
```

---

## 🇦🇺 Australian Retail Context

When presenting this dashboard:
- **EOFY (June 30)** is shown in this data — stock is typically lower after EOFY sales
- Fashion buyers in Australia typically plan inventory **3-6 months ahead** for seasonal collections
- Australian fashion brands (The Iconic, Cotton On, Myer) use tools like **SAP**, **NetSuite**, and **Microsoft Dynamics** for inventory — Power BI is often used on top to visualise this data
