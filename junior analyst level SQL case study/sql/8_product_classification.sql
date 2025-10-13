-- Find products that were never ordered
SELECT 
prod.product_id
,prod.product_name
,cat.name
,*
FROM products prod
LEFT JOIN order_items items ON prod.product_id = items.product_id
LEFT JOIN categories cat ON cat.category_id = prod.category_id
WHERE items.quantity = 0
LIMIT 100;


-- Find products with avg quantity per order greater than 3
WITH average_per_product AS (
  SELECT
  prod.product_id
  ,prod.product_name
  ,AVG(items.quantity) AS "avg_quantity"
  FROM products prod
  LEFT JOIN order_items items ON items.product_id = prod.product_id
  GROUP BY 1, 2
)
SELECT *
FROM average_per_product
WHERE avg_quantity > 3
ORDER BY 1 ASC
LIMIT 100;