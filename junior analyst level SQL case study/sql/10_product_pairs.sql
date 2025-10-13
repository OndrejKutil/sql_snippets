-- top 5 most frequently ordered product pairs

WITH items AS (
  SELECT DISTINCT order_id, product_id
  FROM order_items
)
,pairs AS (
  SELECT i1.product_id AS p1, i2.product_id AS p2
  FROM items i1
  JOIN items i2 
    -- items in the same order
    ON i1.order_id = i2.order_id 
    -- only keep combinations of items (only one from B&A, A&B, not A&A)
    AND i1.product_id < i2.product_id
)
SELECT
pairs.p1
,pairs.p2
,pa.product_name AS "p1_name"
,pb.product_name AS "p2_name"
,COUNT(*) AS "order_count"
FROM pairs
LEFT JOIN products pa ON p1 = pa.product_id
LEFT JOIN products pb ON p2 = pb.product_id
GROUP BY 1, 2, 3, 4
ORDER BY 5 DESC, 3, 4
LIMIT 5;

/*

-- CTE for generating unique unordered pairs of products (only A&B, not B&A or A&A)
WITH pairs AS (
    SELECT p1.product_name AS "p1", p2.product_name AS "p2"
    FROM products p1
    CROSS JOIN products p2
    WHERE p1.product_id < p2.product_id
);


-- combinations by name (not product_id), without A&A
WITH pairs AS (
  SELECT p1.product_name AS p1, p2.product_name AS p2
  FROM products p1
  CROSS JOIN products p2
  WHERE LOWER(p1.product_name) < LOWER(p2.product_name)
);

*/