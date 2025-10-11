-- Top 5 products by revenue
WITH order_items AS (
  SELECT product_id, SUM(quantity * unit_price) AS "revenue", SUM(quantity) AS "quantity"
  FROM order_items
  GROUP BY product_id
)
,products AS (
  SELECT product_id, product_name, category_id
  FROM products
)
,categories AS (
  SELECT *
  FROm categories
)
SELECT prod.product_name, cat.name AS "category_name", ord.revenue, ord.quantity
FROM order_items ord
LEFT JOIN products prod ON ord.product_id = prod.product_id
LEFT JOIN categories cat ON prod.category_id = cat.category_id
ORDER BY 3 DESC
LIMIT 5;

-- Top 5 products by quantity sold
WITH order_items AS (
  SELECT product_id, SUM(quantity * unit_price) AS "revenue", SUM(quantity) AS "quantity"
  FROM order_items
  GROUP BY product_id
)
,products AS (
  SELECT product_id, product_name, category_id
  FROM products
)
,categories AS (
  SELECT *
  FROm categories
)
SELECT prod.product_name, cat.name AS "category_name", ord.revenue, ord.quantity
FROM order_items ord
LEFT JOIN products prod ON ord.product_id = prod.product_id
LEFT JOIN categories cat ON prod.category_id = cat.category_id
ORDER BY 4 DESC
LIMIT 5;