-- Returns only segments and regions that had revenues greater than average (2023)
SELECT client_segment, region, sum(revenue_czk) AS "sum_revenue"
FROM revenues
WHERE date_part('year', date) = 2023
GROUP BY region, client_segment
HAVING sum(revenue_czk) > (
  SELECT avg(subq."sum_revenue_subq")
  FROM (
    SELECT sum(revenue_czk) AS "sum_revenue_subq"
    FROM revenues
    WHERE date_part('year', date) = 2023
    GROUP BY region, client_segment
  ) AS subq
)
ORDER BY client_segment, region ASC
