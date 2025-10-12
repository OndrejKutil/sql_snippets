SELECT concat(cus.first_name, cus.last_name), cus.region, SUM(ord.total_amount) AS "total_revenue", COUNT(DISTINCT order_id) AS "total_orders", SUM(ord.total_amount) / COUNT(DISTINCT order_id) AS "average_order_value"
FROM customers cus
LEFT JOIN orders ord ON cus.customer_id = ord.customer_id
GROUP BY 1, 2
ORDER BY 3 DESC NULLS LAST
LIMIT 10;