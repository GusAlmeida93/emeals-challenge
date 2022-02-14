SELECT
CAST(to_char(order_date, 'MM') AS int) month_order,
CAST(to_char(order_date, 'YYYY') AS INT) as year_order,
brand,
product_category,
UPPER(product_name) AS product_name,
SUM(cost) as total_cost
FROM interview.groceryorders
WHERE
UPPER(product_category) = 'CHICKEN'
GROUP BY
month_order,
year_order,
brand,
product_category,
product_name