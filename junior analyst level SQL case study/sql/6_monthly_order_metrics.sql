-- Task 6: Monthly order metrics
-- For each month, calculate the total quantity of items ordered, total revenue, and the category that contributed the most to the revenue.

-- CTE to find the category with the highest revenue for each month
WITH biggest_category_by_revenue_monthly AS (
  SELECT 
  calc.date_formatted
  ,calc.name
  ,calc.category_id
  ,calc.total_revenue_per_category
  FROM (
    SELECT 
    to_char(ord.order_date, 'YYYY-MM') AS "date_formatted"
    ,cat.name
    ,cat.category_id
    ,SUM(items.quantity * items.unit_price) AS "total_revenue_per_category"
    ,ROW_NUMBER() OVER (PARTITION BY to_char(ord.order_date, 'YYYY-MM') ORDER BY SUM(items.quantity * items.unit_price) DESC) AS "rank"
    
    FROM orders ord
    LEFT JOIN order_items items ON ord.order_id = items.order_id
    LEFT JOIN products prod ON prod.product_id = items.product_id
    LEFT JOIN categories cat ON prod.category_id = cat.category_id
    GROUP BY 1, 2, 3
  ) calc
  WHERE rank = 1
)
,orders_formatted AS (
  SELECT to_char(ord.order_date, 'YYYY-MM') AS "date", *
  FROM orders ord
)
SELECT 
ord.date AS "month"
,SUM(items.quantity) AS "quantity"
,SUM(ord.total_amount) AS "revenue"
,bc.name AS "biggest_contributor"
FROM orders_formatted ord
LEFT JOIN order_items items ON ord.order_id = items.order_id
LEFT JOIN biggest_category_by_revenue_monthly bc ON bc.date_formatted = ord.date
GROUP BY 1, 4
ORDER BY 3 DESC, 1 ASC