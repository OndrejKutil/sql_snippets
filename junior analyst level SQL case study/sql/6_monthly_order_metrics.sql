-- Task 6: Monthly order metrics
-- For each month, calculate the total quantity of items ordered, total revenue, and the category that contributed the most to the revenue.

-- CTE to find the category with the highest revenue for each month
WITH biggest_category_by_revenue_monthly AS (
  SELECT 
  calc.date_formatted
  ,calc.category_name
  ,calc.category_id
  ,calc.total_revenue_per_category
  -- Should there be multiple categories with the same max revenue, we pick one arbitrarily (first one presented)
  ,ROW_NUMBER() OVER (PARTITION BY calc.date_formatted, calc.total_revenue_per_category) AS rn
  FROM (
    SELECT 
    to_char(ord.order_date, 'YYYY-MM') AS "date_formatted"
    ,cat.name AS "category_name"
    ,cat.category_id
    ,SUM(items.quantity * items.unit_price) AS "total_revenue_per_category"
    ,MAX(SUM(items.quantity * items.unit_price)) OVER (PARTITION BY to_char(ord.order_date, 'YYYY-MM')) AS "monthly_max_revenue"
    
    FROM orders ord
    LEFT JOIN order_items items ON ord.order_id = items.order_id
    LEFT JOIN products prod ON prod.product_id = items.product_id
    LEFT JOIN categories cat ON prod.category_id = cat.category_id
    -- Group by month, category
    GROUP BY 1, 2, 3
    ORDER BY 1
  ) calc
  WHERE total_revenue_per_category = monthly_max_revenue
)
,orders_formatted AS (
  SELECT to_char(ord.order_date, 'YYYY-MM') AS "date", *
  FROM orders ord
)
SELECT 
ord.date AS "month"
,SUM(items.quantity) AS "quantity"
,SUM(ord.total_amount) AS "revenue"
,bc.category_name AS "biggest_contributor"
FROM orders_formatted ord
LEFT JOIN order_items items ON ord.order_id = items.order_id
LEFT JOIN biggest_category_by_revenue_monthly bc ON bc.date_formatted = ord.date
-- Use only one category per month
WHERE bc.rn = 1
GROUP BY 1, 4
ORDER BY 3 DESC, 1 ASC;