drop database music_store_db;
create database Supply_Chain_Analysis;
use Supply_Chain_Analysis;

/* 1. How many orders were placed in January 2017 in the sales_test.csv dataset? */

SELECT COUNT(ORDER_NO) as Order_placed_in_January
FROM sales_test 
WHERE DATE LIKE '%January%';

/* 2. What is the total number of units ordered (NS_ORDER) in February 2017? */

select sum(ns_order) as "total number of units ordered"
from sales_test
where date like '%February%';

/* 3. Find the number of canceled orders (NC_ORDER) for each customer in canceled_test.csv. */

select customer_no, count(nc_order)
from canceled_test
group by customer_no;

/* 4. How many unique customers are there in the sales_test.csv dataset? */

SELECT COUNT(DISTINCT CUSTOMER_NO) as unique_customers
FROM sales_test;

/* 5. Find the average number of items ordered (NS_ORDER) per order in the sales_test.csv dataset. */

select avg(ns_order)
from sales_test

/* 6. List the top 5 items that have been ordered the most in the sales_test.csv. */

SELECT ITEM, SUM(NS_ORDER) as total_ordered
FROM sales_test
GROUP BY ITEM
ORDER BY total_ordered DESC
LIMIT 5;

/* 7. Find the total number of successful orders (NS_ORDER) where the CUSTOMER_NO is either 1857566 or 1358538 and the DATE is in January 2017. */

select customer_no, sum(ns_order) as "total number of successful orders"
from sales_test
where (CUSTOMER_NO = 1857566 or CUSTOMER_NO = 1358538) and DATE like "%January%"
group by customer_no;


/* Intermediate */


/* 8. Find the total number of units ordered (NS_ORDER) and canceled (NC_ORDER) for each item that appears in both sales_test.csv and canceled_test.csv. 
Include items that have been both ordered and canceled. */

SELECT  s.ITEM,
				SUM(s.NS_ORDER) as total_ordered,
				SUM(c.NC_ORDER) as total_canceled
FROM sales_test s
INNER JOIN canceled_test c
ON s.ITEM = c.ITEM
GROUP BY s.ITEM;

/* 9. Compare the number of canceled orders (NC_ORDER) and successful orders (NS_ORDER) for the same items. */

select sales_test.item, sum(sales_test.ns_order) as "number of successful orders" , sum(canceled_test.nc_order) as "number of canceled orders" 
from sales_test
left join canceled_test on sales_test.item = canceled_test.item
group by sales_test.item;

/* 10. Classify each order in the sales_test.csv dataset as 'High', 'Medium', or 'Low' based on the number of units ordered (NS_ORDER):
- 'High' if NS_ORDER is greater than 50.
- 'Medium' if NS_ORDER is between 20 and 50.
- 'Low' if NS_ORDER is less than 20.*/

select order_no, ns_order,
CASE
WHEN ns_order > 50 Then "High"
WHEN ns_order Between 20 And 50 Then "Medium"
WHEN ns_order < 20 Then "Low"
END
from sales_test;

/* 11. Calculate the percentage of shipped items (NS_SHIP) out of the total ordered (NS_ORDER) for each customer in sales_test.csv. */
select customer_no, sum(ns_ship) / sum(ns_order) * 100 as "percentage of shipped items out of total ordered items"
from sales_test
group by customer_no;

/* 12. Find the top 3 customers with the most canceled orders in canceled_test.csv. */

select customer_no, sum(nc_order) as "number of canceled order"
from canceled_test
group by customer_no
order by SUM(nc_order) desc limit 3;

/* 13. List all the items that have been canceled more than shipped in canceled_test.csv. */

select item, sum(nc_order), sum(nc_ship)
from canceled_test
group by item
having sum(nc_order) >sum(nc_ship);

/* 14. Find the customer who placed the largest number of orders in January 2017 from the sales_test.csv dataset. */

select customer_no, count(ns_order)
from sales_test
where date Like '%January%'
group by customer_no
order by count(ns_order) desc limit 1;

/* Advanced */

/* 15. For each customer, calculate the cumulative total of ordered units (NS_ORDER) over time and rank the orders by date. 
Show the ORDER_NO, CUSTOMER_NO, NS_ORDER, DATE, and the cumulative total of ordered units. */

SELECT ORDER_NO, CUSTOMER_NO, NS_ORDER, DATE, 
    SUM(NS_ORDER) OVER (PARTITION BY CUSTOMER_NO ORDER BY DATE) AS cumulative_ordered_units,
    ROW_NUMBER() OVER (PARTITION BY CUSTOMER_NO ORDER BY DATE) AS order_rank
FROM sales_test
ORDER BY CUSTOMER_NO, DATE;
   
/* 16. Find the top 3 customers who have the highest total number of canceled orders (NC_ORDER) from canceled_test.csv and their 
corresponding total sales (NS_ORDER) from sales_test.csv. */

-- CTE to calculate total canceled orders for each customer
WITH canceled_orders AS (
    SELECT CUSTOMER_NO, SUM(NC_ORDER) AS total_canceled
    FROM canceled_test
    GROUP BY CUSTOMER_NO
)

-- Query to join the CTE with the sales data
SELECT c.CUSTOMER_NO, c.total_canceled, COALESCE(SUM(s.NS_ORDER), 0) AS total_sales
FROM canceled_orders c
LEFT JOIN sales_test s ON c.CUSTOMER_NO = s.CUSTOMER_NO
GROUP BY c.CUSTOMER_NO, c.total_canceled
ORDER BY c.total_canceled DESC
LIMIT 3;

/* 17. Find out the contribution of top 5 customers (by total NS_ORDER) to overall sales. */

WITH total_sales AS (
  SELECT SUM(NS_ORDER) AS total_sales FROM sales_test
),
top_customers AS (
  SELECT CUSTOMER_NO, SUM(NS_ORDER) AS customer_sales 
  FROM sales_test 
  GROUP BY CUSTOMER_NO 
  ORDER BY customer_sales DESC 
  LIMIT 5
)
SELECT CUSTOMER_NO, customer_sales / (SELECT total_sales FROM total_sales) * 100 AS contribution_percentage 
FROM top_customers;

/* 18. Perform an ABC classification of items in sales_test.csv, where:

- Class A: Top 20% of items contributing to 80% of total sales.
- Class B: Next 30% of items contributing to 15% of total sales.
- Class C: Remaining 50% of items. */

WITH total_sales AS (
  SELECT ITEM, SUM(NS_ORDER) AS item_sales 
  FROM sales_test 
  GROUP BY ITEM
),
ranked_sales AS (
  SELECT ITEM, item_sales, 
         NTILE(100) OVER (ORDER BY item_sales DESC) AS percentile 
  FROM total_sales
)
SELECT ITEM, 
       CASE 
         WHEN percentile <= 20 THEN 'A' 
         WHEN percentile <= 50 THEN 'B' 
         ELSE 'C' 
       END AS abc_class 
FROM ranked_sales;








