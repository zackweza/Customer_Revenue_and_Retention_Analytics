# Customer_Revenue_and_Retention_Analytics
# Customer Revenue and Retention Analytics

## Project Overview

This project explores customer purchasing behavior, transaction revenue, and sales trends using the Online Retail dataset. The goal is to demonstrate a structured business analytics workflow, investigate relevant business questions, and communicate findings that could support business decisions.

## Business Questions

- How does net transaction revenue change over time?
- Which countries generate the highest net transaction revenue?
- Which product descriptions generate the highest net transaction revenue?
- What do the observed patterns suggest about the retailer's markets and products?

## Tools and Technologies

- **Python:** Data analysis
- **Pandas:** Data inspection, transformation, and aggregation
- **Matplotlib:** Data visualization
- **SQL / SQLite:** Database queries and business analysis

## Analysis and Visualizations

The current analysis includes:

1. **Monthly Net Revenue Trend** — examines changes in transaction revenue over time.
2. **Revenue by Country** — compares net transaction revenue across countries, excluding the United Kingdom in the displayed top-10 comparison.
3. **Top Products by Net Transaction Revenue** — ranks product descriptions by their calculated net transaction revenue.

## Preliminary Findings

- Monthly net transaction revenue varies over the observed period.
- The Netherlands, EIRE, Germany, and France rank highly among the countries examined outside the United Kingdom.
- Postage-related descriptions appear among the highest-ranked product descriptions, so merchandise performance should be evaluated separately from postage charges.

## Dataset Scope and Limitations

The current Pandas DataFrame contains **541,909 rows and 8 original columns**. The observed transaction dates range from 1 December 2010 to 9 December 2011.

This is not the full combined two-period Online Retail II dataset. The current findings must therefore be interpreted as results from the dataset loaded for this analysis, not as results covering both periods.

Revenue is calculated as `Quantity × UnitPrice`. It is described as net transaction revenue because returns and cancelled transactions may affect the totals. Revenue is not the same as profit.

## Project Structure

The repository contains the analysis notebook, SQL scripts, and supporting dataset files used during the project.

## Future Improvements

- Verify and analyze the correctly combined two-period dataset.
- Refine sales and cancellation handling using documented business rules.
- Extend customer revenue and retention analysis.
- Validate analytical results across Python and SQL.

## Conclusion

This project demonstrates the use of Python, SQL, and data visualization to investigate retail transaction data and communicate preliminary business findings. The dataset scope and analytical limitations are documented so that the results can be interpreted appropriately.


