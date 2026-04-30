# Power BI Dashboard — Instructions
## TrendHive Sales Analysis Dashboard

---

## 🎯 Goal
Build a 1-page Power BI dashboard that visually answers the 5 business questions from this project.

---

## 🛠️ Step-by-Step Instructions

### Step 1 — Connect to Your Data

1. Open **Power BI Desktop**
2. Click **Home > Get Data > Text/CSV**
3. Select the file: `data/sales_data.csv`
4. Click **Load**
5. You should see the `sales_data` table in the right-hand **Fields** panel

---

### Step 2 — Check Your Data in Power Query

1. Click **Transform Data** (opens Power Query Editor)
2. Check that:
   - `sale_date` is detected as **Date** type
   - `total_amount` and `unit_price` are **Decimal Number**
   - `quantity` is **Whole Number**
   - Text fields are **Text**
3. If `sale_date` shows as Text, click the column > **Change Type > Date**
4. Click **Close & Apply**

---

### Step 3 — Create a Date Table (Best Practice!)

In Power BI, it's best practice to have a separate Date table for time analysis.

1. Go to **Home > New Table** and paste this formula:

```
DateTable = CALENDAR(DATE(2024,1,1), DATE(2024,6,30))
```

2. Add a Month Name column:
```
Month Name = FORMAT('DateTable'[Date], "MMMM YYYY")
```

---

### Step 4 — Build Your Visuals

Build these 5 visuals on one page:

#### 📊 Visual 1 — Revenue by Category (Bar Chart)
- **Visualisation:** Clustered Bar Chart
- **Y-axis:** `category`
- **X-axis:** `total_amount` (set to **Sum**)
- **Title:** "Revenue by Product Category"

#### 🗺️ Visual 2 — Sales by Location (Map or Bar Chart)
- **Visualisation:** Clustered Column Chart
- **X-axis:** `store_location`
- **Y-axis:** `total_amount` (Sum)
- **Title:** "Total Revenue by Store Location"

#### 📈 Visual 3 — Monthly Revenue Trend (Line Chart)
- **Visualisation:** Line Chart
- **X-axis:** `sale_date` (set to Month level)
- **Y-axis:** `total_amount` (Sum)
- **Title:** "Monthly Revenue Trend — Jan to Jun 2024"

#### 🏆 Visual 4 — Top 5 Products (Table or Bar Chart)
- **Visualisation:** Table
- **Columns:** `product_name`, `category`, Sum of `quantity`, Sum of `total_amount`
- **Sort by:** Sum of `quantity` descending
- **Title:** "Top Products by Units Sold"

#### 💳 Visual 5 — KPI Cards (3 cards)
- **Card 1:** Total Revenue → `SUM(sales_data[total_amount])`
- **Card 2:** Total Transactions → `COUNT(sales_data[transaction_id])`
- **Card 3:** Avg Order Value → `AVERAGE(sales_data[total_amount])`

---

### Step 5 — Add Slicers (Filters)

Slicers let dashboard users filter the data themselves.

1. Add a **Slicer** visual
2. Field: `store_location`
3. Add another **Slicer**
4. Field: `category`

---

### Step 6 — Format Your Dashboard

- Change the page background colour to a light neutral (e.g. #F5F5F5)
- Use a consistent colour theme (try the built-in **Colorblind safe** theme)
- Add a title text box at the top: **"TrendHive Sales Dashboard — H1 2024"**
- Add your name at the bottom

---

### Step 7 — Export & Save

1. **File > Save As** → save as `trendhive_sales_dashboard.pbix`
2. Take a screenshot of your finished dashboard
3. Save the screenshot in this folder as `dashboard_screenshot.png`

---

## 💡 Power BI Beginner Tips

| Tip | Why It Matters |
|---|---|
| Always check column data types first | Wrong types cause calculation errors |
| Use Card visuals for key metrics (KPIs) | Managers always want the big numbers first |
| Add slicers so users can self-serve | This makes your dashboard interactive |
| Keep it simple — 1 page, 5 visuals max | Less is more in dashboard design |
| Always add a title and date range | So viewers know what they're looking at |

---

## 🇦🇺 Australian Fashion Industry Context

When presenting this dashboard in a job interview, mention:
- **EOFY (End of Financial Year)** = June — huge retail sales period in Australia
- **Boxing Day** = 26 December — biggest sales day in Australian retail
- **Back to School** = January/February — key period for fashion basics
