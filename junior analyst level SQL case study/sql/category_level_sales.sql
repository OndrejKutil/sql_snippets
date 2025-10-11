WITH order_items AS (
  SELECT product_id, SUM(quantity * unit_price) AS "revenue", SUM(quantity) AS "quantity"
  FROM order_items
  GROUP BY product_id
)
,categories AS (
  SELECT *
  FROM categories
)
,products AS (
  SELECT product_id, category_id
  FROM products
)
SELECT cat.name, cat.category_id, SUM(ord.revenue) as "total_revenue", SUM(ord.quantity) AS "total_quantity", COUNT(ord.product_id) AS "distinct_products_sold"
FROM order_items ord 
LEFT JOIN products prod ON ord.product_id = prod.product_id
LEFT JOIN categories cat ON prod.category_id = cat.category_id
GROUP BY 1, 2
ORDER BY 3 DESC;