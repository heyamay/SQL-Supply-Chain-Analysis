# SQL Supply Chain Analysis
![banner-supply-chain-management-vector-illustration-concept-icon-with-management-analysis-plan-product-procurement-logistic-distribution-2RBW8J0_enhanced](https://github.com/user-attachments/assets/17740f6b-ecbe-4ff9-8d56-511350b47e77)

## Overview
This project demonstrates a comprehensive analysis of supply chain data using SQL. It covers a range of insights such as order trends, customer behavior, item popularity, and advanced classifications. The dataset includes sales data (`sales_test.csv`) and cancellations data (`canceled_test.csv`). The queries are categorized into **Easy**, **Intermediate**, and **Advanced** levels based on complexity.

## Features
- **Basic Analytics**: Total orders, unique customers, and average items ordered.
- **Customer Insights**: Top customers, canceled orders, and successful order rates.
- **Item Trends**: Top-ordered items, ABC classification, and canceled vs. shipped items.
- **Advanced Techniques**: Cumulative sales, order rankings, and customer contributions to sales.

## Tools and Technologies
- **Database**: SQLite (or any SQL-supported database)
- **Programming Language**: SQL
- **Dataset**: `sales_test.csv` and `canceled_test.csv`
- **Deployment**: Available on GitHub for exploration and learning.

## Query Categories

### Easy Level
1. **Orders in January 2017**: Count of orders placed in January 2017.
2. **Units Ordered in February 2017**: Total number of units ordered.
3. **Canceled Orders per Customer**: Number of canceled orders for each customer.
4. **Unique Customers**: Count of unique customers.
5. **Average Items Ordered**: Average number of items ordered per order.
6. **Top 5 Ordered Items**: List of the most ordered items.
7. **Successful Orders for Specific Customers**: Total successful orders by selected customers.

### Intermediate Level
8. **Units Ordered vs. Canceled**: Comparison of orders and cancellations for items appearing in both datasets.
9. **Canceled vs. Successful Orders**: A detailed comparison for the same items.
10. **Order Classification**: Categorization of orders as 'High', 'Medium', or 'Low' based on volume.
11. **Shipped Items Percentage**: Calculation of shipped items as a percentage of ordered items for each customer.
12. **Top 3 Customers with Canceled Orders**: Identification of customers with the highest cancellations.
13. **Items Canceled More than Shipped**: Items with more cancellations than shipments.
14. **Top Ordering Customer in January 2017**: Identification of the customer with the most orders.

### Advanced Level
15. **Cumulative Ordered Units**: Cumulative total of ordered units ranked by date for each customer.
16. **Top 3 Customers by Canceled Orders**: Analysis of customers with the most cancellations and their total sales.
17. **Top Customers' Contribution to Sales**: Percentage contribution of top 5 customers to total sales.
18. **ABC Classification**: Classification of items into A, B, and C categories based on sales contribution.

## Dataset
### 1. `sales_test.csv`
Contains details about orders placed, including:
- `ORDER_NO`: Order ID
- `CUSTOMER_NO`: Customer ID
- `ITEM`: Item ordered
- `NS_ORDER`: Number of items ordered
- `NS_SHIP`: Number of items shipped
- `DATE`: Date of the order

### 2. `canceled_test.csv`
Contains information on cancellations, including:
- `CUSTOMER_NO`: Customer ID
- `ITEM`: Item canceled
- `NC_ORDER`: Number of items canceled
- `NC_SHIP`: Number of canceled items shipped

## How to Use
1. Clone the repository:
   ```bash
   git clone https://github.com/<your-username>/sql-supply-chain-analysis.git
