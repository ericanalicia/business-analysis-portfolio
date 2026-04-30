-- ============================================================
-- PROJECT 1: TrendHive Fashion Retail — Sales Analysis
-- Script 02: Load & Clean Data
-- ============================================================
-- BEGINNER TIP:
-- In DB Browser for SQLite, to import the CSV:
--   1. Go to File > Import > Table from CSV file
--   2. Select sales_data.csv from the /data folder
--   3. Make sure "First row contains column names" is checked
--   4. Click OK — data is now loaded!
--
-- After importing, run the queries below to check and clean the data.
-- ============================================================

-- -------------------------------------------------------
-- STEP 1: Check how many rows were loaded
-- -------------------------------------------------------
SELECT COUNT(*) AS total_rows FROM sales;
-- Expected: 90 rows


-- -------------------------------------------------------
-- STEP 2: Preview the first 10 rows
-- -------------------------------------------------------
SELECT * FROM sales LIMIT 10;


-- -------------------------------------------------------
-- STEP 3: Check for NULL (missing) values in key columns
-- -------------------------------------------------------
-- BEGINNER TIP: NULL means empty/missing data. Real datasets
-- often have nulls — always check for them!

SELECT
    COUNT(*) AS total_rows,
    COUNT(sale_date) AS has_date,
    COUNT(store_location) AS has_location,
    COUNT(category) AS has_category,
    COUNT(total_amount) AS has_amount
FROM sales;


-- -------------------------------------------------------
-- STEP 4: Check for duplicate transaction IDs
-- -------------------------------------------------------
-- A transaction_id should be unique. If any ID appears more
-- than once, that's a data quality issue.

SELECT
    transaction_id,
    COUNT(*) AS occurrences
FROM sales
GROUP BY transaction_id
HAVING COUNT(*) > 1;
-- Expected: 0 rows (no duplicates)


-- -------------------------------------------------------
-- STEP 5: Check all distinct categories
-- -------------------------------------------------------
-- Make sure no typos or unexpected categories exist

SELECT DISTINCT category FROM sales ORDER BY category;
-- Expected: Accessories, Bottoms, Dresses, Footwear, Tops


-- -------------------------------------------------------
-- STEP 6: Check all store locations
-- -------------------------------------------------------
SELECT DISTINCT store_location FROM sales ORDER BY store_location;
-- Expected: Brisbane, Melbourne, Online, Perth, Sydney


-- -------------------------------------------------------
-- STEP 7: Verify total_amount = quantity × unit_price
-- -------------------------------------------------------
-- This catches any calculation errors in the source data

SELECT
    transaction_id,
    quantity,
    unit_price,
    total_amount,
    ROUND(quantity * unit_price, 2) AS calculated_amount,
    CASE
        WHEN ROUND(quantity * unit_price, 2) = total_amount THEN 'OK'
        ELSE '⚠️ MISMATCH'
    END AS check_result
FROM sales
WHERE ROUND(quantity * unit_price, 2) != total_amount;
-- Expected: 0 rows (all amounts are correct)


-- -------------------------------------------------------
-- ✅ Data is clean! Move on to Script 03 for analysis.
-- -------------------------------------------------------
