-- Gross profit and ratio for each month and region (2023)
SELECT 
  rev."date_formatted", 
  region, 
  ("sum_revenue" - "sum_expenses") AS "gross_profit",
  round(("sum_expenses" / "sum_revenue") * 100, 2) AS "cost_to_revenue_ratio_pct"
FROM ((
  SELECT to_char(date, 'YYYY-MM') AS "date_formatted", region, sum(revenue_czk) AS "sum_revenue"
  FROM revenues
  WHERE date_part('year', date) = 2023
  GROUP BY "date_formatted", region
) AS rev
JOIN (
  SELECT to_char(date, 'YYYY-MM') AS "date_formatted", sum(amount_czk) AS "sum_expenses"
  FROM expenses
  WHERE date_part('year', date) = 2023
  GROUP BY "date_formatted"
) AS expen
ON rev."date_formatted" = expen."date_formatted"
)
ORDER BY rev."date_formatted", region
