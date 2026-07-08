> ✅ **Completed** — Business questions answered with real SQL queries and results below. See [Results & Key Findings](#-results--key-findings) for a full walkthrough.

# 📊 Project 1 — Fashion Retail Sales Analysis

## Overview

**Scenario:**
You are a Junior Business Analyst hired by *TrendHive*, a fictional mid-size Australian fashion retailer with stores in Sydney, Melbourne, Brisbane, and Perth. The sales manager wants to understand how the business is performing and where to focus marketing efforts.

**Your job:** Analyse 6 months of sales data, identify trends, and present findings in a Power BI dashboard.

---

## 🎯 Business Questions to Answer

1. Which product category generates the most revenue?
2. Which city/state has the highest sales?
3. What are the top 5 best-selling products?
4. Which months had the highest and lowest sales?
5. What is the average order value per customer?

---

## 📈 Results & Key Findings

### 1. Which product category generates the most revenue?

```sql
SELECT category, SUM(total_amount) AS total_revenue
FROM sales
GROUP BY category
ORDER BY total_revenue DESC;
```

| category | total_revenue |
|---|---|
| Dresses | 3419.62 |
| Tops | 2839.37 |
| Footwear | 2619.71 |
| Bottoms | 2269.70 |
| Accessories | 2189.67 |

**Insight:** Dresses is the top-performing category, generating roughly 20% more revenue than the next closest category (Tops). This suggests marketing spend and stock investment could lean more heavily toward Dresses.

---

### 2. Which city/state has the highest sales?

```sql
SELECT store_location, ROUND(SUM(total_amount), 2) AS total_revenue
FROM sales
GROUP BY store_location
ORDER BY total_revenue DESC;
```

| store_location | total_revenue |
|---|---|
| Online | 3389.52 |
| Perth | 2869.66 |
| Sydney | 2749.59 |
| Melbourne | 2419.64 |
| Brisbane | 1909.66 |

**Insight:** Online sales outperform every physical store location, generating more revenue than even the top brick-and-mortar store (Perth). This suggests TrendHive's e-commerce channel is a strong growth area worth further marketing investment.

---

### 3. What are the top 5 best-selling products?

```sql
SELECT product_name, SUM(quantity) AS total_quantity
FROM sales
GROUP BY product_name
ORDER BY total_quantity DESC
LIMIT 5;
```

| product_name | total_quantity |
|---|---|
| Floral Wrap Dress | 38 |
| Striped T-Shirt | 24 |
| White Linen Shirt | 22 |
| Gold Hoop Earrings | 20 |
| High-Waist Jeans | 17 |

**Insight:** The Floral Wrap Dress is the clear standout, selling 38 units — over 50% more than the next best-seller (Striped T-Shirt at 24). This aligns with Dresses being the top revenue-generating category overall, suggesting this single product is a major driver of that category's performance.

---

### 4. Which months had the highest and lowest sales?

```sql
SELECT strftime('%Y-%m', sale_date) AS month,
       SUM(total_amount) AS total_revenue
FROM sales
GROUP BY strftime('%Y-%m', sale_date)
ORDER BY month ASC;
```

| month | total_revenue |
|---|---|
| 2024-01 | 1519.78 |
| 2024-02 | 1984.72 |
| 2024-03 | 2129.66 |
| 2024-04 | 2244.66 |
| 2024-05 | 2799.62 |
| 2024-06 | 2659.63 |

**Insight:** Revenue grew steadily every month from January ($1,519.78) to a peak in May ($2,799.62) — a 5-month consistent upward trend — before dipping slightly in June. This pattern suggests strengthening demand through autumn, with June's slight pullback worth investigating (e.g. seasonal shift, reduced marketing spend, or stock availability issues).

---

### 5. What is the average order value per customer?

```sql
SELECT ROUND(AVG(total_amount), 2) AS avg_order_value
FROM sales;
```

| avg_order_value |
|---|
| 148.20 |

**Insight:** The average order value across all transactions is $148.20, giving a baseline benchmark for evaluating future campaigns — e.g. whether a promotion increases basket size above this figure.

---

## 📂 Folder Structure

```
project-01-fashion-sales-analysis/
│
├── data/
│   └── sales_data.csv          ← Sample dataset (created by you in Step 1)
│
├── sql/
│   ├── 01_create_tables.sql    ← Step 2: Create the database
│   ├── 02_load_data.sql        ← Step 3: Load and clean data
│   └── 03_analysis_queries.sql ← Step 4: Answer business questions
│
├── powerbi/
│   └── INSTRUCTIONS.md         ← Step 5: How to build your dashboard
│
└── docs/
    ├── business_requirements.md ← Step 1: Business Analysis document
    └── insights_report.md       ← Step 6: Your findings (fill this in!)
```

---

## 🛠️ Tools You'll Need

| Tool | Download Link | Cost |
|---|---|---|
| DB Browser for SQLite | https://sqlitebrowser.org/ | Free |
| Power BI Desktop | https://powerbi.microsoft.com/ | Free |
| VS Code | Already installed ✅ | Free |

---
