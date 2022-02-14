SELECT
C.client,
C.brand,
COUNT(DISTINCT G.member_id) 
FROM interview.groceryorders AS G
LEFT JOIN interview.clientbrand AS C
ON G.brand = C.brand
WHERE
UPPER(C.client) = 'BARILLA'
AND
order_date BETWEEN '2020-02-01' AND '2020-02-29'
AND
UPPER(product_category) = 'PASTA'
GROUP BY
C.client,
C.brand