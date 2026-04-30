-- ============================================================
-- PROJECT 1: TrendHive Fashion Retail — Sales Analysis
-- Script 03: Analysis Queries
-- ============================================================
-- BEGINNER TIP:
-- Each query below answers one of the 5 business questions.
-- Run them one at a time. Read the comments before each query.
-- After running, write down what you find in docs/insights_report.md
-- ============================================================


-- ============================================================
-- BUSINESS QUESTION 1:
-- Which product category generates the most revenue?
-- ============================================================
-- CONCEPTS USED: GROUP BY, SUM, ORDER BY, ROUND

SELECT
    category,
    SUM(total_amount)                          AS total_revenue,
    ROUND(SUM(total_amount), 2)                AS total_revenue_rounded,
    COUNT(transaction_id)                      AS number_of_transactions,
    ROUND(AVG(total_amount), 2)                AS avg_transaction_value
FROM sales
GROUP BY category
ORDER BY total_revenue DESC;

-- 💡 WHAT TO LOOK FOR:
-- Which category is at the top? Which is at the bottom?
-- Is the result surprising? Why might Dresses outperform Tops?


-- ============================================================
-- BUSINESS QUESTION 2:
-- Which city/store has the highest total sales?
-- ============================================================
-- CONCEPTS USED: GROUP BY, SUM, ORDER BY

SELECT
    store_location,
    ROUND(SUM(total_amount), 2)   AS total_revenue,
    COUNT(transaction_id)         AS number_of_sales,
    ROUND(AVG(total_amount), 2)   AS avg_sale_value
FROM sales
GROUP BY store_location
ORDER BY total_revenue DESC;

-- 💡 WHAT TO LOOK FOR:
-- Is Sydney or Melbourne leading? How does Online compare to physical stores?
-- What might explain differences between cities?


-- ============================================================
-- BUSINESS QUESTION 3:
-- What are the top 5 best-selling products by quantity?
-- ============================================================
-- CONCEPTS USED: GROUP BY, SUM, LIMIT

SELECT
    product_id,
    product_name,
    category,
    SUM(quantity)                  AS total_units_sold,
    ROUND(SUM(total_amount), 2)    AS total_revenue,
    ROUND(AVG(unit_price), 2)      AS unit_price
FROM sales
GROUP BY product_id, product_name, category
ORDER BY total_units_sold DESC
LIMIT 5;

-- 💡 WHAT TO LOOK FOR:
-- Is the best-selling item also the highest revenue item?
-- (Not always! A cheap item sold many times can outsell an expensive item)


-- ============================================================
-- BUSINESS QUESTION 4:
-- Which months had the highest and lowest sales?
-- ============================================================
-- CONCEPTS USED: strftime (date function), GROUP BY, ORDER BY

SELECT
    strftime('%Y-%m', sale_date)   AS year_month,
    ROUND(SUM(total_amount), 2)    AS monthly_revenue,
    COUNT(transaction_id)          AS number_of_transactions,
    SUM(quantity)                  AS total_units_sold
FROM sales
GROUP BY year_month
ORDER BY year_month ASC;

-- 💡 WHAT TO LOOK FOR:
-- Is there a clear peak month? A slow month?
-- Think about the Australian fashion calendar:
--   - March = Autumn fashion launches
--   - June = End of Financial Year sales (EOFY)
--   - January = Post-Christmas sales


-- ============================================================
-- BUSINESS QUESTION 5:
-- What is the average order value (AOV) per customer?
-- ============================================================
-- CONCEPTS USED: AVG, ROUND, subquery

-- Average across all transactions
SELECT
    ROUND(AVG(total_amount), 2)  AS average_order_value,
    ROUND(MIN(total_amount), 2)  AS minimum_order,
    ROUND(MAX(total_amount), 2)  AS maximum_order,
    COUNT(transaction_id)        AS total_transactions
FROM sales;

-- Average order value by channel (In-Store vs Online)
SELECT
    channel,
    ROUND(AVG(total_amount), 2)  AS avg_order_value,
    COUNT(transaction_id)        AS total_transactions
FROM sales
GROUP BY channel
ORDER BY avg_order_value DESC;

-- 💡 WHAT TO LOOK FOR:
-- Do online customers spend more or less than in-store customers?
-- This is a key metric for retail strategy!


-- ============================================================
-- BONUS QUERY: Monthly revenue by category (great for Power BI!)
-- ============================================================
-- Export this result as a CSV and import into Power BI for a
-- line chart showing how each category trends over time.

SELECT
    strftime('%Y-%m', sale_date)  AS year_month,
    category,
    ROUND(SUM(total_amount), 2)   AS monthly_revenue
FROM sales
GROUP BY year_month, category
ORDER BY year_month, category;
