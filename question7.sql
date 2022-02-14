WITH count_table AS(
SELECT
to_char(order_date, 'MM') as month_order,
to_char(order_date, 'YYYY') as year_order,
member_id,
COUNT(order_id) as qty_orders,
COUNT(DISTINCT vendor) as qty_vendors
FROM interview.groceryorders
GROUP BY
month_order,
year_order,
member_id
),
group_table AS (
SELECT
month_order,
year_order,
SUM(CASE WHEN qty_orders >= 2 THEN 1 ELSE 0 END) AS qty_order_gt_2,
COUNT(member_id) AS customers,
SUM(CASE WHEN qty_vendors >= 2 THEN 1 ELSE 0 END) AS qty_vendor_gt_2
FROM count_table
GROUP BY
month_order,
year_order)

SELECT
month_order,
year_order,
customers,
qty_order_gt_2,
qty_vendor_gt_2,
CAST(qty_order_gt_2 AS DECIMAL) / customers AS customers_with_order_gt_2,
CAST(qty_vendor_gt_2 AS DECIMAL) / customers AS customers_with_vendor_gt_2
FROM
group_table
GROUP BY
month_order,
year_order,
customers,
qty_order_gt_2,
qty_vendor_gt_2