-- Gross profit and ratio for each month and region (2023)
SELECT 
  rev."date_formatted", 
  region, 
  round(("sum_revenue" - "expenses_per_region"), 2) AS "gross_profit",
  round(("expenses_per_region" / "sum_revenue") * 100, 2) AS "cost_to_revenue_ratio_pct"
FROM ((
  -- Get monthly revenue by region and month
  SELECT 
    to_char(date, 'YYYY-MM') AS "date_formatted", 
    region, 
    sum(revenue_czk) AS "sum_revenue"
  FROM revenues
  WHERE date_part('year', date) = 2023
  GROUP BY "date_formatted", region
) AS rev
JOIN (
  SELECT 
    expen_with_count."date_formatted",
    (expen_with_count."sum_expenses" / expen_with_count."region_count") AS "expenses_per_region"
  FROM (
    SELECT 
      expen."date_formatted",
      expen."sum_expenses",
      region_counts."region_count"
    FROM (
      -- Get total expenses per month
      SELECT 
        to_char(date, 'YYYY-MM') AS "date_formatted", 
        sum(amount_czk) AS "sum_expenses"
      FROM expenses
      WHERE date_part('year', date) = 2023
      GROUP BY "date_formatted"
    ) AS expen
    JOIN (
      -- Count distinct active regions per month
      SELECT 
        to_char(date, 'YYYY-MM') AS "date_formatted",
        count(DISTINCT region) AS "region_count"
      FROM revenues
      WHERE date_part('year', date) = 2023
      GROUP BY "date_formatted"
    ) AS region_counts
    ON expen."date_formatted" = region_counts."date_formatted"
  ) AS expen_with_count
) AS expen_split
ON rev."date_formatted" = expen_split."date_formatted"
)
ORDER BY rev."date_formatted", region