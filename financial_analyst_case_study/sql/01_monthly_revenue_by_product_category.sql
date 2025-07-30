-- Monthly revenue by product category, date formatted and sorted descending (2023)
SELECT to_char(date, 'YYYY-MM') AS "date_formatted", product_category, sum(revenue_czk) AS "total_sum"
FROM revenues
WHERE date_part('year', date) = 2023
GROUP BY "date_formatted", product_category
ORDER BY "total_sum" DESC
