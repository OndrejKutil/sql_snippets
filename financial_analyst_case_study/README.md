# Financial Analyst Case Study

## Table Schemas

### revenues

| Column           | Type   | Description           |
|------------------|--------|-----------------------|
| date             | DATE   | Date of revenue       |
| region           | TEXT   | Region name           |
| product_category | TEXT   | Product category      |
| client_segment   | TEXT   | Client segment        |
| revenue_czk      | NUMBER | Revenue in CZK        |

### expenses

| Column     | Type   | Description           |
|------------|--------|-----------------------|
| date       | DATE   | Date of expense       |
| cost_type  | TEXT   | Type of cost          |
| department | TEXT   | Department name       |
| amount_czk | NUMBER | Expense amount in CZK |

---

### SQL Query Summaries

1. **Monthly revenue by product category (2023)**
   - Shows monthly revenues by product category for 2023, with date formatted as YYYY-MM, sorted by revenue descending.
   - [01_monthly_revenue_by_product_category.sql](./sql/01_monthly_revenue_by_product_category.sql)

2. **Gross profit and cost-to-revenue ratio by month and region (2023)**
   - Calculates gross profit (revenues - expenses) and cost-to-revenue ratio (%) for each month and region in 2023. Assumes expenses are distributed equally across regions unless a region column is present in expenses.
   - [02_gross_profit_and_ratio_by_month_region.sql](./sql/02_gross_profit_and_ratio_by_month_region.sql)

3. **Revenue classification**
   - Adds a column classifying each revenue as Low (< 100,000 CZK), Medium (100,000–500,000 CZK), or High (> 500,000 CZK).
   - [03_revenue_classification.sql](./sql/03_revenue_classification.sql)

4. **Segments and regions above average revenue (2023)**
   - Lists client segments and regions where total revenues in 2023 exceeded the average across all segments and regions.
   - [04_segments_regions_above_average.sql](./sql/04_segments_regions_above_average.sql)
