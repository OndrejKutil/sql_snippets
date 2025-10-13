WITH orders_enhanced AS (
  SELECT *
  ,CASE 
    WHEN total_amount < 100 THEN 'Small'
    WHEN total_amount <= 500 THEN 'Medium'
    WHEN total_amount > 500 THEN 'High'
    ELSE NULL
    END AS "revenue_class"
  FROM orders
)
SELECT
COUNT(CASE WHEN revenue_class = 'Small' THEN order_id END) AS "num_small_orders"
,COUNT(CASE WHEN revenue_class = 'Medium' THEN order_id END) AS "num_medium_orders"
,COUNT(CASE WHEN revenue_class = 'High' THEN order_id END) AS "num_high_orders"
FROM orders_enhanced;