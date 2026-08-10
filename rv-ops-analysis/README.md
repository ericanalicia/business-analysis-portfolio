# Rebecca Vallance — AW24 Operations Analysis

**Scenario:** You are an Operations Analyst supporting the buying and planning team at Rebecca Vallance for the AW24 season. The season launched mid-January 2024. It is now end of March (week 11). Management wants a read on sell-through, channel performance, and which SKUs need action before mid-season.

**Data covers:** 15 SKUs across RTW, Swim, Accessories, and Evening | 3 channels (Sydney, Melbourne, Online) | 116 transactions | January 15 – March 31, 2024

---

## Business Questions

| # | Question | SQL file |
|---|---|---|
| 1 | Which category drives the most revenue? | `02_analysis.sql` — Q1 |
| 2 | Which SKUs generate the most revenue, and at what margin? | `02_analysis.sql` — Q2 |
| 3 | Which store is performing best across revenue, units, and margin? | `02_analysis.sql` — Q3 |
| 4 | Is the season building or tapering off month to month? | `02_analysis.sql` — Q4 |
| 5 | What does each store's category mix look like? | `02_analysis.sql` — Q5 |
| 6 | Which SKUs have the highest sell-through at week 11? | `03_advanced.sql` — OPS 1 |
| 7 | Which SKUs need replenishment or markdown based on weeks of cover? | `03_advanced.sql` — OPS 2 |
| 8 | Which channel has the highest gross margin (not just revenue)? | `03_advanced.sql` — OPS 3 |
| 9 | Is cumulative revenue front-loaded or building across the season? | `03_advanced.sql` — OPS 4 |
| 10 | Are any SKUs exclusive to a single channel? | `03_advanced.sql` — OPS 5 |

---

## File Structure

```
rv-ops-analysis/
├── data/
│   ├── rv_products.csv      ← 15 AW24 SKUs with RRP, cost, and initial stock
│   └── rv_sales.csv         ← 116 transactions across Sydney, Melbourne, Online
└── sql/
    ├── 01_schema.sql        ← Create tables (run first)
    ├── 02_analysis.sql      ← Core revenue and store analysis (5 queries)
    └── 03_advanced.sql      ← Sell-through, weeks of cover, margin, running totals (5 queries)
```

---

## Setup (DB Browser for SQLite)

1. Download DB Browser for SQLite — free at sqlitebrowser.org
2. New Database → save as `rv_aw24.db` in this folder
3. Execute SQL tab → paste and run `01_schema.sql`
4. File → Import → Table from CSV → select `rv_products.csv` (tick "First row is column names")
5. Repeat for `rv_sales.csv`
6. Run each query block in `02_analysis.sql` and `03_advanced.sql` one at a time

---

## Key Findings (fill in after running queries)

| Metric | Result |
|---|---|
| Highest sell-through SKU | |
| SKUs needing replenishment | |
| SKUs at markdown risk | |
| Highest margin store | |
| Strongest revenue month | |

---

## Products in Scope

| SKU | Product | Category | Colour | RRP | Initial Stock |
|---|---|---|---|---|---|
| RV-RTW-001 | Arden Mini Dress | RTW | Ivory | $650 | 24 |
| RV-RTW-002 | Arden Mini Dress | RTW | Black | $650 | 30 |
| RV-RTW-003 | Greta Blazer | RTW | Camel | $750 | 18 |
| RV-RTW-004 | Greta Blazer | RTW | Black | $750 | 24 |
| RV-RTW-005 | Lena Midi Dress | RTW | Blush | $890 | 20 |
| RV-RTW-006 | Lena Midi Dress | RTW | Navy | $890 | 16 |
| RV-RTW-007 | Scarlett Trouser | RTW | Ivory | $450 | 30 |
| RV-RTW-008 | Capri Knit Top | RTW | White | $380 | 36 |
| RV-SWM-001 | Monaco One-Piece | Swim | Ivory | $320 | 20 |
| RV-SWM-002 | Monaco One-Piece | Swim | Black | $320 | 28 |
| RV-SWM-003 | Amalfi Bikini Set | Swim | Sage | $280 | 24 |
| RV-ACC-001 | Camille Clutch | Accessories | Gold | $490 | 12 |
| RV-ACC-002 | Camille Clutch | Accessories | Silver | $490 | 10 |
| RV-ACC-003 | Monogram Belt | Accessories | Black | $220 | 20 |
| RV-EVE-001 | Valentina Gown | Evening | Blush | $1,850 | 8 |

*All data is mock. Product names, pricing, and stock quantities are illustrative, structured to reflect realistic AW season patterns in premium Australian womenswear.*
