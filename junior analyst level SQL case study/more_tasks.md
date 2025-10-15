# Additional advanced tasks

Below are several more advanced analysis tasks for the e-commerce dataset. These tasks build upon the earlier questions (1–10) and start from task 11. They require deeper SQL knowledge, including window functions and recursive common table expressions (CTEs). Use the same tables (`customers`, `categories`, `products`, `orders`, and `order_items`) as in the junior analyst case study.

## 11. Monthly revenue growth

- Create a summary showing total revenue for each month and the month-over-month growth rate.
- Use window functions (`LAG` or `LEAD`) to compute the percentage change in revenue compared with the previous month.
- List months in ascending order with columns: `year_month`, `revenue`, `prev_month_revenue`, and `growth_rate`.

## 12. Cohort analysis

- Perform a customer cohort analysis by registration month.
- For each cohort (customers who registered in the same month), count how many of them placed an order in the first, second, and third month after registration.
- Present the results in a pivot-style table with one row per cohort and three columns: `month_1_orders`, `month_2_orders`, `month_3_orders`.
- Hint: join `customers` and `orders` on `customer_id`, compute the difference in months between `registration_date` and `order_date`, and use conditional aggregation.

## 13. Category contribution by product

- For each product, calculate its share of its category’s revenue.
- First compute total revenue per product (`SUM(quantity * unit_price)`), then compute total revenue per category.
- Use a window function or a subquery to calculate the percentage contribution of each product to its category.
- Return: `product_id`, `product_name`, `category_name`, `product_revenue`, `category_revenue`, and `percentage_of_category` (rounded to two decimals).

## 14. Daily revenue gap analysis (recursive CTE)

Identify the longest consecutive period of days without any orders. To do this:

1. Use a recursive CTE to generate a complete calendar of dates between the minimum and maximum `order_date` values in the `orders` table.
2. Left join this calendar to daily revenue (sum of `quantity * unit_price` grouped by `order_date`). Dates with no orders will have `NULL` revenue.
3. Use window functions or a counter to group consecutive days with `NULL` revenue and find the start date, end date, and length of the longest gap.
4. Return the start and end dates of the longest gap and the number of days in that gap.

## 15. Cross-sell network (recursive CTE)

- For a given product (e.g., `product_id = 1`), find all other products that are directly or indirectly connected through common orders.
  - Definition: product A is related to B if they appear together in any order; B is related to C if they appear together in another order, etc.
- Build a recursive CTE that starts with the specified product and iteratively finds all products purchased together with any product discovered in the previous level.
- Return each related product’s `product_id`, `product_name`, and the `level` (1 for directly connected, 2 for products connected via one intermediary, etc.).
- Be careful to avoid cycles (maintain a visited list or path in the recursion).

These advanced tasks will challenge you to use window functions, conditional aggregation, and recursive CTEs to derive deeper insights from the e-commerce dataset.
