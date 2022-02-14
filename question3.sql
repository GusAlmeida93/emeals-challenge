WITH temp_table AS(
    SELECT
    brand,
    product_category,
    product_name,
    cost / quantity as unit_cost
    FROM interview.groceryorders
    WHERE
    quantity > 0
    AND
    cost > 0
    order by
    unit_cost ASC
),
avg_table AS (
    SELECT
    brand,
    product_category,
    product_name,
    AVG(unit_cost) as avg_unit_cost,
    RANK () OVER (ORDER BY avg_unit_cost ASC) AS rnk_avg_cost
    FROM temp_table
    GROUP BY
    brand,
    product_category,
    product_name
    ORDER BY
    avg_unit_cost ASC
)
SELECT
brand,
product_category,
product_name,
avg_unit_cost
FROM avg_table
WHERE
rnk_avg_cost <= 10