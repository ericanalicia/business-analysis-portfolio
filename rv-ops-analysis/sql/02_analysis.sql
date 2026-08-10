-- ============================================================
-- Rebecca Vallance AW24 — Operations Analysis
-- Script 02: Core Analysis Queries
-- ============================================================
-- Run each block separately in DB Browser for SQLite.
-- After running, note the result and compare to your expectations.
-- ============================================================


-- ============================================================
-- Q1: Revenue by category
-- Which category is driving the most revenue?
-- ============================================================

SELECT
    category,
    SUM(quantity_sold)                                      AS units_sold,
    ROUND(SUM(quantity_sold * sell_price_aud), 2)           AS total_revenue,
    ROUND(SUM(quantity_sold * sell_price_aud) * 100.0
        / SUM(SUM(quantity_sold * sell_price_aud)) OVER (), 1) AS revenue_share_pct
FROM sales
GROUP BY category
ORDER BY total_revenue DESC;

-- What to look for:
-- RTW should lead on revenue. Does Evening punch above its weight despite low unit volume?
-- Which category has the highest revenue share despite fewer units?


-- ============================================================
-- Q2: Top 10 SKUs by revenue (with gross margin %)
-- Which products earn the most AND hold the best margin?
-- ============================================================

SELECT
    sku_id,
    product_name,
    category,
    SUM(quantity_sold)                                                          AS units_sold,
    ROUND(SUM(quantity_sold * sell_price_aud), 2)                               AS total_revenue,
    ROUND(SUM(quantity_sold * (sell_price_aud - cost_price_aud)) * 100.0
        / SUM(quantity_sold * sell_price_aud), 1)                               AS gross_margin_pct
FROM sales
GROUP BY sku_id, product_name, category
ORDER BY total_revenue DESC
LIMIT 10;

-- What to look for:
-- Does the highest revenue SKU also have the best margin?
-- Where does the Valentina Gown rank on revenue despite low unit count?


-- ============================================================
-- Q3: Store performance — revenue, units, and gross margin
-- Which store is the most valuable channel?
-- ============================================================

SELECT
    store,
    COUNT(transaction_id)                                                       AS transactions,
    SUM(quantity_sold)                                                          AS units_sold,
    ROUND(SUM(quantity_sold * sell_price_aud), 2)                               AS total_revenue,
    ROUND(AVG(quantity_sold * sell_price_aud), 2)                               AS avg_transaction_value,
    ROUND(SUM(quantity_sold * (sell_price_aud - cost_price_aud)) * 100.0
        / SUM(quantity_sold * sell_price_aud), 1)                               AS gross_margin_pct
FROM sales
GROUP BY store
ORDER BY total_revenue DESC;

-- What to look for:
-- Does Online lead on units but underperform on margin (lower-priced mix)?
-- Which store has the highest average transaction value?
-- Does Sydney's Evening/Accessories mix lift its gross margin above Melbourne?


-- ============================================================
-- Q4: Monthly revenue trend — is the season building or slowing?
-- ============================================================

SELECT
    strftime('%Y-%m', date)                                 AS month,
    SUM(quantity_sold)                                      AS units_sold,
    ROUND(SUM(quantity_sold * sell_price_aud), 2)           AS monthly_revenue,
    COUNT(transaction_id)                                   AS transactions
FROM sales
GROUP BY month
ORDER BY month;

-- What to look for:
-- Is Jan strong (season launch)? Does March taper off?
-- Any month significantly above or below the others?


-- ============================================================
-- Q5: Category mix by store
-- What does each store actually sell?
-- ============================================================

SELECT
    store,
    category,
    SUM(quantity_sold)                                              AS units_sold,
    ROUND(SUM(quantity_sold * sell_price_aud), 2)                   AS revenue,
    ROUND(SUM(quantity_sold * sell_price_aud) * 100.0
        / SUM(SUM(quantity_sold * sell_price_aud)) OVER (PARTITION BY store), 1)
                                                                    AS pct_of_store_revenue
FROM sales
GROUP BY store, category
ORDER BY store, revenue DESC;

-- What to look for:
-- Is Evening exclusively a Sydney story?
-- Does Melbourne carry a disproportionate Swim mix (and does that affect its margin)?
-- Does Online skew heavily toward entry-price RTW?
