WITH orders_enhanced AS (
  SELECT *
  ,CASE
    WHEN (ord.order_date - cus.registration_date) > 30 THEN TRUE
    ELSE FALSE
    END AS "returning_customer"
  FROM orders ord
  LEFT JOIN customers cus ON cus.customer_id = ord.customer_id
)
SELECT
COUNT(DISTINCT CASE WHEN oh.returning_customer = TRUE THEN order_id END) AS "returning_customer_orders"
,COUNT(DISTINCT CASE WHEN oh.returning_customer = FALSE THEN order_id END) AS "new_customer_orders"
,SUM(CASE WHEN oh.returning_customer = TRUE THEN oh.total_amount END) AS "returning_customer_orders_revenue"
,SUM(CASE WHEN oh.returning_customer = FALSE THEN oh.total_amount END) AS "new_customer_orders_revenue"
FROM orders_enhanced oh;