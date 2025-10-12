SELECT cus.region, COUNT(DISTINCT ord.order_id) AS "total_orders", SUM(ord.total_amount) AS "total_amount", SUM(ord.total_amount) / COUNT(DISTINCT ord.order_id) AS "average_order_value"
FROM customers cus
LEFT JOIN orders ord ON ord.customer_id = cus.customer_id
GROUP BY 1
ORDER BY 4 DESC