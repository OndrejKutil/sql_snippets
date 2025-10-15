WITH monthly_revenues AS (
  SELECT to_char(order_date, 'YYYY-MM') AS "date", SUM(total_amount) AS "revenue"
  FROM orders
  GROUP BY to_char(order_date, 'YYYY-MM')
)
,add_previous_revenues AS (
  SELECT date, revenue AS "current_revenue", LAG(revenue) OVER (ORDER BY date) AS "previous_revenue"
  FROM monthly_revenues
)
SELECT *
,CASE 
  WHEN previous_revenue = Null THEN Null
  ELSE ROUND((((current_revenue - previous_revenue) / previous_revenue) * 100)::numeric, 2)
END AS "pct_change"
FROM add_previous_revenues
ORDER BY date;