-- Online Retail II: Initial SQL data-quality checks
-- Source table: sales
-- Purpose: Inspect the data before applying cleaning rules.

-- 1. Check the total number of records
SELECT COUNT(*) AS total_records
FROM sales;

-- 2. Check exact duplicate rows
SELECT
    COUNT(*) AS duplicate_rows
FROM (
    SELECT
        InvoiceNo,
        StockCode,
        Description,
        Quantity,
        InvoiceDate,
        UnitPrice,
        CustomerID,
        Country,
        COUNT(*) AS occurrences
    FROM sales
    GROUP BY
        InvoiceNo,
        StockCode,
        Description,
        Quantity,
        InvoiceDate,
        UnitPrice,
        CustomerID,
        Country
    HAVING COUNT(*) > 1
);

-- 3. Check missing descriptions
SELECT COUNT(*) AS missing_descriptions
FROM sales
WHERE Description IS NULL;

-- 4. Check zero and negative unit prices
SELECT
    SUM(CASE WHEN UnitPrice = 0 THEN 1 ELSE 0 END)
        AS zero_unit_prices,
    SUM(CASE WHEN UnitPrice < 0 THEN 1 ELSE 0 END)
        AS negative_unit_prices
FROM sales;
SELECT
    Country,
    ROUND(SUM(Quantity * UnitPrice), 2) AS total_revenue
FROM sales
WHERE InvoiceNo NOT LIKE 'C%'
GROUP BY Country
ORDER BY total_revenue DESC
LIMIT 10;


-- Business Question 4: How concentrated is revenue among the top 10 customers?

WITH customer_revenue AS (
    SELECT
        CustomerID,
        SUM(Quantity * UnitPrice) AS total_revenue
    FROM sales
    WHERE InvoiceNo NOT LIKE 'C%'
      AND CustomerID IS NOT NULL
    GROUP BY CustomerID
),
ranked_customers AS (
    SELECT
        CustomerID,
        total_revenue,
        ROW_NUMBER() OVER (
            ORDER BY total_revenue DESC
        ) AS customer_rank
    FROM customer_revenue
)
SELECT
    ROUND(
        SUM(CASE WHEN customer_rank <= 10
            THEN total_revenue ELSE 0 END), 2
    ) AS top_10_revenue,
    ROUND(SUM(total_revenue), 2) AS total_customer_revenue,
    ROUND(
        100.0 * SUM(CASE WHEN customer_rank <= 10
            THEN total_revenue ELSE 0 END)
        / SUM(total_revenue), 2
    ) AS top_10_revenue_pct
FROM ranked_customers;


-- Business Question 2: Which countries generate the most revenue?
-- Exclude cancellation invoices and rank countries by revenue.

SELECT
    Country,
    ROUND(SUM(Quantity * UnitPrice), 2) AS total_revenue,
    COUNT(DISTINCT InvoiceNo) AS invoice_count
FROM sales
WHERE InvoiceNo NOT LIKE 'C%'
GROUP BY Country
ORDER BY total_revenue DESC
LIMIT 10;
