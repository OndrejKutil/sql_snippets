WITH ord AS (
  SELECT order_id, total_amount
  FROM orders
)
,items AS (
  SELECT order_id, SUM(quantity * unit_price) AS "price_total"
  FROM order_items
  GROUP BY order_id
)
SELECT ord.order_id, ord.total_amount AS "order_amount", items."price_total" AS "sum_of_item_amounts", ord.total_amount - items."price_total" AS "difference"
FROM ord
LEFT JOIN items ON ord.order_id = items.order_id;