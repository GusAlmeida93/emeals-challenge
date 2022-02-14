WITH lag_table AS(
SELECT
UPPER(product_category) AS product_category,
CAST(to_char(order_date, 'MM') AS int) month_order,
CAST(to_char(order_date, 'YYYY') AS INT) as year_order,
SUM(cost) as current_month,
LAG(current_month) OVER (PARTITION BY year_order ORDER BY year_order, month_order ASC ) AS previous_month,
current_month / previous_month - 1 AS diff
FROM interview.groceryorders
WHERE
UPPER(product_category) = 'WINE'
GROUP BY
product_category,
month_order,
year_order
)
SELECT
product_category,
month_order,
year_order,
diff
FROM
lag_table