WITH participation_table AS (
SELECT
brand,
to_char(order_date, 'MM') as month_order,
to_char(order_date, 'YYYY') as year_order,
SUM(cost) as total_cost,
SUM(cost) * 100 / SUM(SUM(cost)) OVER(PARTITION BY month_order,year_order ) AS current_participation
FROM interview.groceryorders
WHERE
UPPER(product_category) = 'WINE'
GROUP BY
brand,
month_order,
year_order
),
lag_table AS(
    SELECT
    brand,
    month_order,
    year_order,
    total_cost,
    current_participation,    
    LAG(current_participation) OVER (PARTITION BY brand, year_order ORDER BY brand, year_order, month_order ASC ) AS previous_participation
    FROM participation_table
    GROUP BY
    brand,
    month_order,
    year_order,
    total_cost,
    current_participation
)

SELECT
brand,
month_order,
year_order,
current_participation / previous_participation - 1 as diff
FROM lag_table
WHERE
diff IS NOT NULL
ORDER BY
year_order ASC,
month_order ASC,
diff DESC