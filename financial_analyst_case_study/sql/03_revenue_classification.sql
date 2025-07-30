-- Revenue classification
SELECT 
  *,
  CASE 
    WHEN revenue_czk >= 500000 THEN 'High'
    WHEN revenue_czk >= 100000 THEN 'Medium'
    ELSE 'Low'
  END AS "revenue_class"
FROM revenues
