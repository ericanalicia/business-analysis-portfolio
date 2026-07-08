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

## 🪜 Step-by-Step Learning Guide

### ✅ Step 1 — Read the Business Requirements
Open `docs/business_requirements.md`. This is your brief. Understand what the business needs before touching any data — this is the #1 skill of a Business Analyst.

### ✅ Step 2 — Explore the Data
Open `data/sales_data.csv` in Excel or VS Code. Get familiar with the columns:
- What does each column mean?
- Are there any missing values?
- What date range does the data cover?

### ✅ Step 3 — Set Up the Database
Run `sql/01_create_tables.sql` in DB Browser for SQLite (free tool). This creates your tables.

### ✅ Step 4 — Load & Clean Data
Run `sql/02_load_data.sql`. Learn what data cleaning means — fixing nulls, formatting dates, removing duplicates.

### ✅ Step 5 — Run Analysis Queries
Open `sql/03_analysis_queries.sql`. Each query answers one business question. Run them one by one and write down what you find.

### ✅ Step 6 — Build Your Power BI Dashboard
Follow the instructions in `powerbi/INSTRUCTIONS.md` to connect your data and build charts.

### ✅ Step 7 — Write Your Insights
Fill in `docs/insights_report.md` with what you discovered. Pretend you're presenting to your manager.

---

## 🛠️ Tools You'll Need

| Tool | Download Link | Cost |
|---|---|---|
| DB Browser for SQLite | https://sqlitebrowser.org/ | Free |
| Power BI Desktop | https://powerbi.microsoft.com/ | Free |
| VS Code | Already installed ✅ | Free |

---

## 💡 Skills You'll Practise

- ✅ Reading and writing business requirements (Business Analysis)
- ✅ Designing and querying a relational database (SQL)
- ✅ Cleaning and transforming data (SQL)
- ✅ Building a visual dashboard (Power BI)
- ✅ Communicating findings in plain English (Reporting)
