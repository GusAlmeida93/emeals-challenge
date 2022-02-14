SELECT
CASE
    WHEN vendor = 'kingSoopers' THEN 'kroger'
    WHEN vendor = 'smiths' THEN 'kroger'
    WHEN vendor = 'fredMeyer' THEN 'kroger'
    WHEN vendor = 'frys' THEN 'kroger'
    WHEN vendor = 'picknsave' THEN 'kroger'
    WHEN vendor = 'ralphs' THEN 'kroger'
    WHEN vendor = 'safeway' THEN 'albertsons'
    ELSE vendor
END AS group_vendors,
to_char(order_date, 'MM') as month_order,
to_char(order_date, 'YYYY') as year_order,
SUM(cost) as total_cost,
SUM(cost) * 100 / SUM(SUM(cost)) OVER(PARTITION BY month_order,year_order ) AS percentage_cost
FROM interview.groceryorders
GROUP BY
group_vendors,
month_order,
year_order