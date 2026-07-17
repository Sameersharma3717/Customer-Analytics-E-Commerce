/*
==========================================================
CUSTOMER ANALYTICS & ORDER INTELLIGENCE
==========================================================

Project: Customer Analytics & Order Intelligence
Database: customer_analytics_db

Description:
This SQL project analyzes customer behavior, orders, revenue,
products, sellers, and payment information using the Brazilian
E-Commerce Public Dataset (Olist). The objective is to generate
actionable business insights through SQL analysis.

==========================================================
TABLE OF CONTENTS
==========================================================

1. Database Overview
2. Data Quality Assessment
3. Customer Analysis
4. Revenue Analysis
5. Product Performance Analysis
6. Seller Performance Analysis
7. Time-Based Analysis
8. Advanced SQL Analysis
9. Customer Segmentation (RFM Analysis)
10. Final Project Summary

==========================================================
*/


/*==========================================================
1. DATABASE OVERVIEW
==========================================================*/


-- Q1. Display all available tables

/*
Business Question:
What tables are available in the database?

Business Objective:
Verify that all required tables have been successfully imported
before starting the analysis.
*/

SHOW TABLES;


-- Q2. View customer information

/*
Business Question:
What information is available about customers?

Business Objective:
Inspect the customer dataset and understand its structure.
*/

SELECT *
FROM customer
LIMIT 10;


-- Q3. View order information

/*
Business Question:
What information is available about customer orders?

Business Objective:
Inspect order details including purchase dates, delivery dates,
and order status.
*/

SELECT *
FROM order_
LIMIT 10;


-- Q4. View order items

/*
Business Question:
What products were purchased in each order?

Business Objective:
Explore order item details including product IDs, seller IDs,
pricing, and freight charges.
*/

SELECT *
FROM order_items
LIMIT 10;


-- Q5. View product information

/*
Business Question:
What information is available about products?

Business Objective:
Inspect product-related attributes including categories,
dimensions, and product specifications.
*/

SELECT *
FROM product
LIMIT 10;


-- Q6. View payment information

/*
Business Question:
What payment information is available for customer orders?

Business Objective:
Understand payment methods, installments,
and payment amounts.
*/

SELECT *
FROM payment
LIMIT 10;


-- Q7. View seller information

/*
Business Question:
What information is available about sellers?

Business Objective:
Inspect seller location information and verify seller records.
*/

SELECT *
FROM seller
LIMIT 10;

/*==========================================================
2. DATA QUALITY ASSESSMENT
==========================================================*/

-- Q8. Count total customers

/*
Business Question:
How many customers are present in the database?

Business Objective:
Determine the total customer base available
for customer analytics.
*/

SELECT COUNT(*) AS Total_Customers
FROM customer;


-- Q9. Count total orders

/*
Business Question:
How many orders have been placed?

Business Objective:
Measure the total number of customer orders.
*/

SELECT COUNT(*) AS Total_Orders
FROM order_;


-- Q10. Count total order items

/*
Business Question:
How many products have been sold?

Business Objective:
Determine the total number of order line items
across all customer purchases.
*/

SELECT COUNT(*) AS Total_Order_Items
FROM order_items;


-- Q11. Count total products

/*
Business Question:
How many products are available?

Business Objective:
Measure the total number of products
listed in the marketplace.
*/

SELECT COUNT(*) AS Total_Products
FROM product;


-- Q12. Count total sellers

/*
Business Question:
How many sellers are available?

Business Objective:
Determine the total number of sellers
participating in the marketplace.
*/

SELECT COUNT(*) AS Total_Sellers
FROM seller;


-- Q13. Count total payment records

/*
Business Question:
How many payment transactions are recorded?

Business Objective:
Measure the total number of customer
payment records available.
*/

SELECT COUNT(*) AS Total_Payments
FROM payment;

/*==========================================================
3. CUSTOMER ANALYSIS
==========================================================*/

-- Q14. Count Unique Customers

/*
Business Question:
How many unique customers have placed orders?

Business Objective:
Determine the size of the active customer base.
*/

SELECT COUNT(DISTINCT customer_unique_id) AS Unique_Customers
FROM customer;



-- Q15. Customers by State

/*
Business Question:
Which states have the highest number of customers?

Business Objective:
Identify the geographical distribution of customers to understand
where the business has the strongest customer presence.
*/

SELECT
customer_state,
COUNT(*) AS Total_Customers
FROM customer
GROUP BY customer_state
ORDER BY Total_Customers DESC;


-- Q16. Customers by City

/*
Business Question:
Which cities have the highest number of customers?

Business Objective:
Identify cities with the largest customer base to support
regional marketing and expansion decisions.
*/

SELECT
customer_city,
COUNT(*) AS Total_Customers
FROM customer
GROUP BY customer_city
ORDER BY Total_Customers DESC
LIMIT 10;


-- Q17. Total Orders by Order Status

/*
Business Question:
How many orders fall under each order status?

Business Objective:
Understand the operational performance by analyzing
completed, cancelled, shipped and delivered orders.
*/

SELECT
order_status,
COUNT(*) AS Total_Orders
FROM order_
GROUP BY order_status
ORDER BY Total_Orders DESC;


-- Q18. First and Last Purchase Date

/*
Business Question:
What is the overall purchasing period covered by the dataset?

Business Objective:
Identify the earliest and latest purchase dates to understand
the time span of the available sales data.
*/

SELECT
MIN(order_purchase_timestamp) AS First_Purchase,
MAX(order_purchase_timestamp) AS Last_Purchase
FROM order_;


-- Q19. Total Delivered Orders

/*
Business Question:
How many customer orders were successfully delivered?

Business Objective:
Measure the total number of completed customer deliveries.
*/

SELECT COUNT(*) AS Delivered_Orders
FROM order_
WHERE order_status='delivered';


-- Q20. Total Cancelled Orders

/*
Business Question:
How many customer orders were cancelled?

Business Objective:
Measure cancelled orders to monitor order fulfillment performance.
*/

SELECT COUNT(*) AS Cancelled_Orders
FROM order_
WHERE order_status='canceled';


-- Q21. Delivered Order Percentage

/*
Business Question:
What percentage of total orders were successfully delivered?

Business Objective:
Evaluate delivery performance by calculating the delivery success rate.
*/

SELECT
ROUND(
COUNT(CASE WHEN order_status='delivered' THEN 1 END)*100.0/
COUNT(*),
2
) AS Delivery_Percentage
FROM order_;

/*==========================================================
4. REVENUE ANALYSIS
==========================================================*/

-- Q22. Calculate Total Revenue

/*
Business Question:
What is the total revenue generated from all completed customer orders?

Business Objective:
Measure overall business revenue to evaluate marketplace performance.
*/

SELECT
ROUND(SUM(payment_value),2) AS Total_Revenue
FROM payment;


-- Q23. Calculate Average Order Value

/*
Business Question:
What is the average amount spent per payment transaction?

Business Objective:
Understand the average value generated from each customer payment.
*/

SELECT
ROUND(AVG(payment_value),2) AS Average_Order_Value
FROM payment;


-- Q24. Revenue by Payment Type

/*
Business Question:
Which payment methods generate the highest revenue?

Business Objective:
Identify the most valuable payment methods used by customers.
*/

SELECT
payment_type,
ROUND(SUM(payment_value),2) AS Revenue
FROM payment
GROUP BY payment_type
ORDER BY Revenue DESC;


-- Q25. Number of Orders by Payment Type

/*
Business Question:
Which payment methods are most frequently used by customers?

Business Objective:
Analyze customer payment preferences.
*/

SELECT
payment_type,
COUNT(order_id) AS Total_Orders
FROM payment
GROUP BY payment_type
ORDER BY Total_Orders DESC;


-- Q26. Revenue by Customer State

/*
Business Question:
Which customer states generate the highest revenue?

Business Objective:
Identify high-value geographic markets for business expansion.
*/

SELECT
c.customer_state,
ROUND(SUM(p.payment_value),2) AS Revenue
FROM customer c
JOIN order_ o
ON c.customer_id = o.customer_id
JOIN payment p
ON o.order_id = p.order_id
GROUP BY c.customer_state
ORDER BY Revenue DESC;


-- Q27. Top 10 Cities by Revenue

/*
Business Question:
Which cities contribute the highest revenue?

Business Objective:
Identify top-performing cities for sales and marketing initiatives.
*/

SELECT
c.customer_city,
ROUND(SUM(p.payment_value),2) AS Revenue
FROM customer c
JOIN order_ o
ON c.customer_id=o.customer_id
JOIN payment p
ON o.order_id=p.order_id
GROUP BY c.customer_city
ORDER BY Revenue DESC
LIMIT 10;


-- Q28. Monthly Revenue Trend

/*
Business Question:
How has revenue changed over time?

Business Objective:
Analyze monthly revenue trends to identify seasonality
and business growth patterns.
*/

SELECT
DATE_FORMAT(
STR_TO_DATE(order_purchase_timestamp,'%d-%m-%Y %H:%i'),
'%Y-%m'
) AS Month,
ROUND(SUM(payment_value),2) AS Revenue
FROM order_ o
JOIN payment p
ON o.order_id=p.order_id
GROUP BY Month
ORDER BY Month;

/*==========================================================
5. PRODUCT PERFORMANCE ANALYSIS
==========================================================*/

-- Q29. Top 10 Best Selling Products

/*
Business Question:
Which products have been sold the most?

Business Objective:
Identify the highest-selling products based on total quantity sold.
*/

SELECT
product_id,
SUM(order_item_id) AS Total_Items_Sold
FROM order_items
GROUP BY product_id
ORDER BY Total_Items_Sold DESC
LIMIT 10;


-- Q30. Top 10 Highest Revenue Products

/*
Business Question:
Which products generate the highest revenue?

Business Objective:
Identify products that contribute the most to overall revenue.
*/

SELECT
product_id,
ROUND(SUM(price),2) AS Revenue
FROM order_items
GROUP BY product_id
ORDER BY Revenue DESC
LIMIT 10;


-- Q31. Average Product Price

/*
Business Question:
What is the average selling price of products?

Business Objective:
Understand the overall pricing strategy of products sold.
*/

SELECT
ROUND(AVG(price),2) AS Average_Product_Price
FROM order_items;


-- Q32. Most Expensive Products

/*
Business Question:
Which products have the highest selling price?

Business Objective:
Identify premium-priced products available in the marketplace.
*/

SELECT
product_id,
MAX(price) AS Highest_Price
FROM order_items
GROUP BY product_id
ORDER BY Highest_Price DESC
LIMIT 10;


-- Q33. Product Categories with Highest Revenue

/*
Business Question:
Which product categories generate the highest revenue?

Business Objective:
Identify the most profitable product categories.
*/

SELECT

p.product_category_name,
ROUND(SUM(oi.price),2) AS Revenue
FROM product p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY Revenue DESC
LIMIT 10;


-- Q34. Product Categories with Highest Sales Volume

/*
Business Question:
Which product categories sell the highest number of products?
Business Objective:
Understand customer demand across product categories.
*/

SELECT
p.product_category_name,
COUNT(*) AS Products_Sold
FROM product p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY Products_Sold DESC
LIMIT 10;


-- Q35. Average Freight Cost by Product Category

/*
Business Question:
Which product categories incur the highest average freight cost?

Business Objective:
Analyze shipping costs across different product categories.
*/

SELECT
p.product_category_name,
ROUND(AVG(oi.freight_value),2) AS Average_Freight
FROM product p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_category_name
ORDER BY Average_Freight DESC;


/*==========================================================
6. SELLER PERFORMANCE ANALYSIS
==========================================================*/

-- Q36. Top 10 Sellers by Revenue

/*
Business Question:
Which sellers generate the highest revenue?

Business Objective:
Identify the top-performing sellers based on total sales revenue.
*/

SELECT
seller_id,
ROUND(SUM(price),2) AS Revenue
FROM order_items
GROUP BY seller_id
ORDER BY Revenue DESC
LIMIT 10;


-- Q37. Top 10 Sellers by Orders Fulfilled

/*
Business Question:
Which sellers have fulfilled the highest number of orders?

Business Objective:
Measure seller activity by counting the number of order items fulfilled.
*/

SELECT
seller_id,
COUNT(order_id) AS Total_Orders
FROM order_items
GROUP BY seller_id
ORDER BY Total_Orders DESC
LIMIT 10;


-- Q38. Seller Distribution by State

/*
Business Question:
Which states have the highest number of sellers?

Business Objective:
Understand the geographical distribution of sellers across the marketplace.
*/

SELECT
seller_state,
COUNT(*) AS Total_Sellers
FROM seller
GROUP BY seller_state
ORDER BY Total_Sellers DESC;


-- Q39. Seller Distribution by City

/*
Business Question:
Which cities have the highest number of sellers?

Business Objective:
Identify cities with the strongest seller presence.
*/

SELECT
seller_city,
COUNT(*) AS Total_Sellers
FROM seller
GROUP BY seller_city
ORDER BY Total_Sellers DESC
LIMIT 10;


-- Q40. Average Revenue per Seller

/*
Business Question:
What is the average revenue generated by each seller?

Business Objective:
Evaluate the average financial contribution of marketplace sellers.
*/

SELECT
seller_id,
ROUND(AVG(price),2) AS Average_Revenue
FROM order_items
GROUP BY seller_id
ORDER BY Average_Revenue DESC
LIMIT 10;


-- Q41. Sellers Charging Highest Average Freight

/*
Business Question:
Which sellers have the highest average freight charges?

Business Objective:
Identify sellers with expensive shipping costs.
*/

SELECT
seller_id,
ROUND(AVG(freight_value),2) AS Average_Freight
FROM order_items
GROUP BY seller_id
ORDER BY Average_Freight DESC
LIMIT 10;


-- Q42. Seller Revenue by State

/*
Business Question:
Which seller states generate the highest revenue?

Business Objective:
Evaluate regional seller performance based on revenue generated.
*/

SELECT
s.seller_state,
ROUND(SUM(oi.price),2) AS Revenue
FROM seller s
JOIN order_items oi
ON s.seller_id = oi.seller_id
GROUP BY s.seller_state
ORDER BY Revenue DESC;


/*==========================================================
7. TIME-BASED ANALYSIS
==========================================================*/


-- Q43. Monthly Order Trend

/*
Business Question:
How many orders are placed each month?

Business Objective:
Analyze monthly purchasing trends to identify seasonality.
*/

SELECT
DATE_FORMAT(STR_TO_DATE(order_purchase_timestamp,'%d-%m-%Y %H:%i'),'%Y-%m') AS Month,
COUNT(order_id) AS Total_Orders
FROM order_
GROUP BY Month
ORDER BY Month;


-- Q44. Monthly Revenue Trend

/*
Business Question:
How does revenue change month by month?

Business Objective:
Analyze monthly business performance and revenue trends.
*/

SELECT
DATE_FORMAT(STR_TO_DATE(order_purchase_timestamp,'%d-%m-%Y %H:%i'),'%Y-%m') AS Month,
ROUND(SUM(payment_value),2) AS Revenue
FROM order_ o
JOIN payment p
ON o.order_id = p.order_id
GROUP BY Month
ORDER BY Month;


-- Q45. Orders by Day of Week

/*
Business Question:
On which day of the week are the most orders placed?

Business Objective:
Identify peak shopping days for operational planning.
*/

SELECT
DAYNAME(STR_TO_DATE(order_purchase_timestamp,'%d-%m-%Y %H:%i')) AS Day_Name,
COUNT(*) AS Total_Orders
FROM order_
GROUP BY Day_Name
ORDER BY Total_Orders DESC;


-- Q46. Orders by Month Name

/*
Business Question:
Which months record the highest number of orders?

Business Objective:
Identify seasonal purchasing patterns.
*/

SELECT
MONTHNAME(STR_TO_DATE(order_purchase_timestamp,'%d-%m-%Y %H:%i')) AS Month,
COUNT(*) AS Orders_Placed
FROM order_
GROUP BY Month
ORDER BY Orders_Placed DESC;


-- Q47. Revenue by Quarter

/*
Business Question:
Which quarter generates the highest revenue?

Business Objective:
Compare quarterly business performance.
*/

SELECT
QUARTER(STR_TO_DATE(order_purchase_timestamp,'%d-%m-%Y %H:%i')) AS Quarter,
ROUND(SUM(payment_value),2) AS Revenue
FROM order_ o
JOIN payment p
ON o.order_id = p.order_id
GROUP BY Quarter
ORDER BY Revenue DESC;


-- Q48. Average Monthly Revenue

/*
Business Question:
What is the average monthly revenue?

Business Objective:
Measure average monthly business performance.
*/

SELECT
ROUND(AVG(Monthly_Revenue),2) AS Average_Monthly_Revenue
FROM
(
SELECT
DATE_FORMAT(STR_TO_DATE(order_purchase_timestamp,'%d-%m-%Y %H:%i'),'%Y-%m') AS Month,
SUM(payment_value) AS Monthly_Revenue
FROM order_ o
JOIN payment p
ON o.order_id = p.order_id
GROUP BY Month
) t;


-- Q49. Peak Revenue Month

/*
Business Question:
Which month generated the highest revenue?

Business Objective:
Identify the highest-performing month.
*/

SELECT
DATE_FORMAT(STR_TO_DATE(order_purchase_timestamp,'%d-%m-%Y %H:%i'),'%Y-%m') AS Month,
ROUND(SUM(payment_value),2) AS Revenue
FROM order_ o
JOIN payment p
ON o.order_id = p.order_id
GROUP BY Month
ORDER BY Revenue DESC
LIMIT 1;


-- Q50. Peak Order Month

/*
Business Question:
Which month recorded the highest number of orders?

Business Objective:
Identify the busiest sales month.
*/

SELECT
DATE_FORMAT(STR_TO_DATE(order_purchase_timestamp,'%d-%m-%Y %H:%i'),'%Y-%m') AS Month,
COUNT(*) AS Orders_Placed
FROM order_
GROUP BY Month
ORDER BY Orders_Placed DESC
LIMIT 1;

/*==========================================================
8. ADVANCED SQL ANALYSIS
==========================================================*/

-- Q51. Top 10 Customers by Revenue

/*
Business Question:
Who are the highest-value customers?

Business Objective:
Identify customers contributing the highest revenue.
*/

SELECT
c.customer_unique_id,
ROUND(SUM(p.payment_value),2) AS Total_Revenue
FROM customer c
JOIN order_ o
ON c.customer_id = o.customer_id
JOIN payment p
ON o.order_id = p.order_id
GROUP BY c.customer_unique_id
ORDER BY Total_Revenue DESC
LIMIT 10;


-- Q52. Rank Customers by Revenue

/*
Business Question:
How do customers rank based on total revenue generated?

Business Objective:
Rank customers according to their contribution to business revenue.
*/

SELECT
c.customer_unique_id,
ROUND(SUM(p.payment_value),2) AS Total_Revenue,
RANK() OVER(ORDER BY SUM(p.payment_value) DESC) AS Revenue_Rank
FROM customer c
JOIN order_ o
ON c.customer_id = o.customer_id
JOIN payment p
ON o.order_id = p.order_id
GROUP BY c.customer_unique_id;


-- Q53. Top Seller in Each State

/*
Business Question:
Who is the highest revenue-generating seller in each state?

Business Objective:
Identify the best-performing seller within every seller state.
*/

WITH SellerRevenue AS
(
SELECT
s.seller_state,
s.seller_id,
ROUND(SUM(oi.price),2) AS Revenue,
RANK() OVER(PARTITION BY s.seller_state ORDER BY SUM(oi.price) DESC) AS Seller_Rank
FROM seller s
JOIN order_items oi
ON s.seller_id = oi.seller_id
GROUP BY s.seller_state,s.seller_id
)
SELECT *
FROM SellerRevenue
WHERE Seller_Rank = 1;


-- Q54. Running Revenue Analysis

/*
Business Question:
How does cumulative revenue grow over time?

Business Objective:
Track cumulative business revenue using a running total.
*/

WITH MonthlyRevenue AS(
SELECT
DATE_FORMAT(STR_TO_DATE(order_purchase_timestamp,'%d-%m-%Y %H:%i'),'%Y-%m') AS Month,
SUM(payment_value) AS Revenue
FROM order_ o
JOIN payment p
ON o.order_id = p.order_id
GROUP BY Month
)
SELECT
Month,
Revenue,
SUM(Revenue) OVER(ORDER BY Month) AS Running_Revenue
FROM MonthlyRevenue;


-- Q55. Top 5 Product Categories by Revenue

/*
Business Question:
Which product categories contribute the highest revenue?

Business Objective:
Identify the most profitable product categories.
*/

SELECT
pr.product_category_name,
ROUND(SUM(oi.price),2) AS Revenue,
DENSE_RANK() OVER(ORDER BY SUM(oi.price) DESC) AS Category_Rank
FROM product pr
JOIN order_items oi
ON pr.product_id = oi.product_id
GROUP BY pr.product_category_name
LIMIT 5;


/*==========================================================
9. CUSTOMER SEGMENTATION (RFM ANALYSIS)
==========================================================*/


-- Q56. Customer Purchase Frequency

/*
Business Question:
Which customers place the highest number of orders?

Business Objective:
Identify repeat customers based on purchase frequency.
*/

SELECT
c.customer_unique_id,
COUNT(o.order_id) AS Total_Orders
FROM customer c
JOIN order_ o
ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
ORDER BY Total_Orders DESC
LIMIT 10;


-- Q57. Customer Monetary Value

/*
Business Question:
Which customers spend the most money?

Business Objective:
Identify high-value customers based on total spending.
*/

SELECT
c.customer_unique_id,
ROUND(SUM(p.payment_value),2) AS Monetary_Value
FROM customer c
JOIN order_ o
ON c.customer_id = o.customer_id
JOIN payment p
ON o.order_id = p.order_id
GROUP BY c.customer_unique_id
ORDER BY Monetary_Value DESC
LIMIT 10;


-- Q58. Customer Recency

/*
Business Question:
Which customers purchased most recently?

Business Objective:
Measure customer recency by identifying each customer's latest purchase date.
*/

SELECT
c.customer_unique_id,
MAX(STR_TO_DATE(o.order_purchase_timestamp,'%d-%m-%Y %H:%i')) AS Last_Purchase_Date
FROM customer c
JOIN order_ o
ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
ORDER BY Last_Purchase_Date DESC
LIMIT 10;


-- Q59. Customer RFM Segmentation

/*
Business Question:
How can customers be segmented using their purchasing behavior?

Business Objective:
Classify customers into business-friendly segments based on
Recency, Frequency and Monetary Value.
*/

WITH Customer_RFM AS (
SELECT
c.customer_unique_id,
DATEDIFF((
SELECT MAX(STR_TO_DATE(order_purchase_timestamp,'%d-%m-%Y %H:%i'))
FROM order_
),
MAX(STR_TO_DATE(o.order_purchase_timestamp,'%d-%m-%Y %H:%i'))
) AS Recency,
COUNT(o.order_id) AS Frequency,
ROUND(SUM(p.payment_value),2) AS Monetary
FROM customer c
JOIN order_ o
ON c.customer_id = o.customer_id
JOIN payment p
ON o.order_id = p.order_id
GROUP BY c.customer_unique_id
)
SELECT *,
CASE
WHEN Monetary >=1000 AND Frequency>=5 THEN 'Champions'
WHEN Monetary>=500 AND Frequency>=3 THEN 'Loyal Customers'
WHEN Frequency>=2 THEN 'Potential Loyalists'
ELSE 'Occasional Customers'
END AS Customer_Segment
FROM Customer_RFM
ORDER BY Monetary DESC;


-- Q60. Top 10 Customer Lifetime Value (CLV)

/*
Business Question:
Which customers contribute the highest lifetime value?

Business Objective:
Identify customers generating the highest long-term revenue.
*/

SELECT
c.customer_unique_id,
ROUND(SUM(p.payment_value),2) AS Customer_Lifetime_Value
FROM customer c
JOIN order_ o
ON c.customer_id = o.customer_id
JOIN payment p
ON o.order_id = p.order_id
GROUP BY c.customer_unique_id
ORDER BY Customer_Lifetime_Value DESC
LIMIT 10;


/*==========================================================
FINAL PROJECT SUMMARY
==========================================================

Project Name:
Customer Analytics & Order Intelligence

Database:
Brazilian E-Commerce Public Dataset (Olist)

Tables Used:
1. customer
2. order_
3. order_items
4. product
5. payment
6. seller

==========================================================
PROJECT HIGHLIGHTS
==========================================================

• 60 Business-Oriented SQL Questions
• Multi-Table Relational Database Analysis
• Data Quality Assessment
• Customer Analytics
• Revenue Analysis
• Product Performance Analysis
• Seller Performance Analysis
• Payment Analysis
• Time-Based Analysis
• Customer Segmentation (RFM)
• Customer Lifetime Value Analysis

==========================================================
SQL CONCEPTS DEMONSTRATED
==========================================================

✓ SELECT
✓ WHERE
✓ ORDER BY
✓ GROUP BY
✓ HAVING
✓ Aggregate Functions
✓ CASE Statements
✓ INNER JOIN
✓ Multi-Table JOINs
✓ Common Table Expressions (CTEs)
✓ Window Functions
✓ RANK()
✓ DENSE_RANK()
✓ Running Totals
✓ Date Functions
✓ STR_TO_DATE()
✓ DATE_FORMAT()
✓ MONTHNAME()
✓ QUARTER()
✓ DAYNAME()

==========================================================
BUSINESS OUTCOMES
==========================================================

The analysis provides insights into:

• Customer purchasing behavior
• Revenue generation
• Product performance
• Seller performance
• Geographic trends
• Payment preferences
• Seasonal demand
• Customer Lifetime Value
• RFM Customer Segmentation

==========================================================
END OF SQL PROJECT
==========================================================