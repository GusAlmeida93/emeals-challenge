SELECT 
V.member_id,
SUM(V.views) as total_views,
COUNT(G.order_id) as total_orders
FROM interview.app_views AS V
INNER JOIN interview.groceryorders AS G
ON V.member_id = G.member_id 
GROUP BY
V.member_id