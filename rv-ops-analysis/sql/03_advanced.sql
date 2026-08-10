-- ============================================================
-- Rebecca Vallance AW24 — Operations Analysis
-- Script 03: Advanced Operations Queries
-- ============================================================
-- These are the queries that separate an operations analyst
-- from a generic data analyst. They answer the questions a
-- buying team or ops manager actually asks week to week.
-- ============================================================


-- ============================================================
-- OPS QUERY 1: Sell-through rate by SKU
-- % of initial buy that has already sold at week 11.
-- ============================================================
-- Requires a JOIN between sales and products tables.

SELECT
    p.sku_id,
    p.product_name,
    p.category,
    p.colour,
    p.initial_stock                                                         AS bought_units,
    COALESCE(SUM(s.quantity_sold), 0)                                       AS sold_units,
    p.initial_stock - COALESCE(SUM(s.quantity_sold), 0)                     AS stock_remaining,
    ROUND(COALESCE(SUM(s.quantity_sold), 0) * 100.0 / p.initial_stock, 1)   AS sell_through_pct
FROM products p
LEFT JOIN sales s ON p.sku_id = s.sku_id
GROUP BY p.sku_id, p.product_name, p.category, p.colour, p.initial_stock
ORDER BY sell_through_pct DESC;

-- What to look for:
-- Capri Knit Top should be near 90%+ — a fast mover at an accessible price point.
-- Swim SKUs should be the slowest — selling swim in an AW season is a slow burn.
-- Greta Blazer in Black may underperform vs. Camel (colour story).
-- Any SKU above 80% sell-through at week 11 is a candidate for reorder or mark-up protection.
-- Any SKU below 40% needs a markdown plan before end of season.


-- ============================================================
-- OPS QUERY 2: Weeks of cover (WoC) remaining
-- At the current rate of sale, how many weeks of stock left?
-- ============================================================
-- WoC = stock remaining / average weekly sales rate
-- Based on 11 weeks of data (Jan 15 – Mar 31, 2024)

WITH weekly_sales AS (
    SELECT
        sku_id,
        ROUND(SUM(quantity_sold) * 1.0 / 11, 2)    AS avg_weekly_units
    FROM sales
    GROUP BY sku_id
),
stock_remaining AS (
    SELECT
        p.sku_id,
        p.product_name,
        p.category,
        p.initial_stock - COALESCE(SUM(s.quantity_sold), 0) AS remaining_units
    FROM products p
    LEFT JOIN sales s ON p.sku_id = s.sku_id
    GROUP BY p.sku_id, p.product_name, p.category, p.initial_stock
)
SELECT
    sr.sku_id,
    sr.product_name,
    sr.category,
    sr.remaining_units,
    ws.avg_weekly_units,
    ROUND(sr.remaining_units / NULLIF(ws.avg_weekly_units, 0), 1)   AS weeks_of_cover,
    CASE
        WHEN sr.remaining_units / NULLIF(ws.avg_weekly_units, 0) < 2
            THEN 'REPLENISH NOW'
        WHEN sr.remaining_units / NULLIF(ws.avg_weekly_units, 0) < 4
            THEN 'Monitor closely'
        WHEN sr.remaining_units / NULLIF(ws.avg_weekly_units, 0) > 12
            THEN 'Consider markdown'
        ELSE 'OK'
    END AS action_flag
FROM stock_remaining sr
LEFT JOIN weekly_sales ws ON sr.sku_id = ws.sku_id
ORDER BY weeks_of_cover ASC;

-- What to look for:
-- SKUs flagged REPLENISH NOW are at risk of stockout before season end.
-- SKUs with 12+ weeks of cover on an AW season ending ~June may need markdown.
-- Swim SKUs will likely have the longest WoC — this signals an overstock position.


-- ============================================================
-- OPS QUERY 3: Gross margin by store (with revenue context)
-- Which channel is most profitable, not just highest revenue?
-- ============================================================

SELECT
    store,
    ROUND(SUM(quantity_sold * sell_price_aud), 2)                                           AS revenue,
    ROUND(SUM(quantity_sold * (sell_price_aud - cost_price_aud)), 2)                        AS gross_profit,
    ROUND(SUM(quantity_sold * (sell_price_aud - cost_price_aud)) * 100.0
        / SUM(quantity_sold * sell_price_aud), 1)                                           AS gross_margin_pct,
    ROUND(SUM(quantity_sold * sell_price_aud) * 100.0
        / SUM(SUM(quantity_sold * sell_price_aud)) OVER (), 1)                              AS revenue_share_pct
FROM sales
GROUP BY store
ORDER BY gross_margin_pct DESC;

-- What to look for:
-- Sydney's Evening and Accessories mix carries a slightly higher margin than a pure RTW store.
-- Online drives volume via lower-priced RTW and Swim — watch whether higher units offset lower margin per unit.
-- A store with high revenue share but the lowest margin is a flag worth raising to the buying team.


-- ============================================================
-- OPS QUERY 4: Running cumulative revenue by week
-- Is the season front-loaded or building toward March?
-- ============================================================

SELECT
    strftime('%Y-W%W', date)                                AS week,
    MIN(date)                                               AS week_start,
    ROUND(SUM(quantity_sold * sell_price_aud), 2)           AS weekly_revenue,
    ROUND(SUM(SUM(quantity_sold * sell_price_aud))
        OVER (ORDER BY strftime('%Y-W%W', date)), 2)        AS cumulative_revenue
FROM sales
GROUP BY week
ORDER BY week;

-- What to look for:
-- If week 1-2 carry 40%+ of cumulative revenue, this is a front-loaded season — common for launches.
-- A flat or growing trend into March suggests sustained demand without over-reliance on the drop.
-- This view is useful for planning future season buy quantities.


-- ============================================================
-- OPS QUERY 5: SKUs sold exclusively in one channel
-- Useful for understanding channel-exclusive demand.
-- ============================================================

SELECT
    sku_id,
    product_name,
    category,
    GROUP_CONCAT(DISTINCT store)        AS sold_in_channels,
    COUNT(DISTINCT store)               AS channel_count,
    SUM(quantity_sold)                  AS total_units
FROM sales
GROUP BY sku_id, product_name, category
HAVING COUNT(DISTINCT store) = 1
ORDER BY total_units DESC;

-- What to look for:
-- Are any SKUs only appearing in one channel? This may indicate a ranging or merch decision
-- or simply that demand for that product is concentrated — worth flagging to the buying team.
