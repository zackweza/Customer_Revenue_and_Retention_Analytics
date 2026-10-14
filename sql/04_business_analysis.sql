-- Online Retail II: Business Analysis
-- Project: Customer Revenue and Retention Analytics
-- Source table: sales
-- Database: retail.db
-- Purpose: Answer agreed business questions using SQL.
-- Note: Queries are documented in the notebook and can also be
-- executed directly from this SQL file using the SQLite extension.ote: Queries are documented and executed in the analysis notebook.

-- Business Question 1: Monthly Revenue Trends
-- Purpose: Calculate monthly revenue, excluding cancellation invoices.

-- Business Question 1: Monthly Revenue Trends
-- Purpose: Calculate monthly revenue, excluding cancellation invoices.

SELECT
    strftime('%Y-%m', InvoiceDate) AS sales_month,
    ROUND(SUM(Quantity * UnitPrice), 2) AS revenue
FROM sales
WHERE InvoiceNo NOT LIKE 'C%'
GROUP BY strftime('%Y-%m', InvoiceDate)
ORDER BY sales_month;




SELECT
    strftime('%Y-%m', InvoiceDate) AS sales_month,
    ROUND(SUM(Quantity * UnitPrice), 2) AS revenue
FROM sales
WHERE InvoiceNo NOT LIKE 'C%'
GROUP BY strftime('%Y-%m', InvoiceDate)
ORDER BY sales_month;

-- Business Question 3: Which customers generate the most revenue?
-- Exclude cancellation invoices and records without CustomerID.

SELECT
    CustomerID,
    ROUND(SUM(Quantity * UnitPrice), 2) AS total_revenue,
    COUNT(DISTINCT InvoiceNo) AS invoice_count
FROM sales
WHERE InvoiceNo NOT LIKE 'C%'
  AND CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY total_revenue DESC
LIMIT 10;

-- Business Question 3: Which customers generate the most revenue?
-- Exclude cancellation invoices and records without CustomerID.

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


-- Business Question 7: How many customers make repeat purchases?
-- Count distinct non-cancelled invoices for each identified customer.

WITH customer_orders AS (
    SELECT
        CustomerID,
        COUNT(DISTINCT InvoiceNo) AS invoice_count
    FROM sales
    WHERE InvoiceNo NOT LIKE 'C%'
      AND CustomerID IS NOT NULL
    GROUP BY CustomerID
)
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN invoice_count > 1 THEN 1 ELSE 0 END)
        AS repeat_customers,
    ROUND(
        100.0 * SUM(CASE WHEN invoice_count > 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS repeat_customer_pct
FROM customer_orders;

-- Total revenue: compare all transactions with
-- revenue excluding cancellation invoices.

SELECT
    ROUND(SUM(Quantity * UnitPrice), 2)
        AS gross_transaction_value,

    ROUND(
        SUM(
            CASE
                WHEN InvoiceNo NOT LIKE 'C%'
                THEN Quantity * UnitPrice
                ELSE 0
            END
        ),
        2
    ) AS revenue_excluding_cancellations
FROM sales;

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
