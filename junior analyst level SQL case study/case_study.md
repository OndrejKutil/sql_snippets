# E‑commerce Sales Analysis Case Study

## Scenario

You are working as a junior data analyst for a small online retailer. The company sells products in several categories — electronics, clothing, home & kitchen, books, sports & outdoors, beauty & personal care, toys & games, and automotive. Customers register on the website, browse the catalogue, and place orders. Each order can contain multiple items, and prices can vary slightly from the catalogue price due to promotions or seasonal pricing. The data covers orders from 1 January 2024 to 30 September 2025.

To perform your analysis, you will import several CSV files into a database (e.g., Supabase, Postgres, MySQL). The tables mirror a typical e‑commerce data model: customers, products, categories, orders, and order_items. In this model, a customer may place many orders, each order may contain multiple items, and each item refers to a single product. Orders store the order date and total price, while order‑item rows store the quantity and unit price at the time of sale.

## Data overview

After extracting the ZIP archive, you should have five CSV files. Import each CSV file as a table. A high‑level description of each table is provided below:

| Table       | Description                                                                                                                                               | Key columns                                                                                                     |
|-------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------|
| categories  | Contains one row per product category.                                                                                                                    | category_id (PK), name                                                                                          |
| products    | List of products available for sale. Each product belongs to exactly one category. The price column holds the catalogue price.                            | product_id (PK), product_name, category_id (FK to categories), price                                           |
| customers   | Registered users who can place orders. Each record includes the region where the customer is located and the date they registered.                        | customer_id (PK), first_name, last_name, email, region, registration_date                                      |
| orders      | Summary information for each order. Each order belongs to a single customer. The total_amount column is the sum of the order’s items.                     | order_id (PK), customer_id (FK to customers), order_date, total_amount                                         |
| order_items | Details of individual line items in orders. Each row links an order to a product and records the quantity ordered and the unit price at the time of sale. | order_item_id (PK), order_id (FK to orders), product_id (FK to products), quantity, unit_price                 |

To verify the data load, run simple checks like:

```sql
-- Row counts
SELECT COUNT(*) AS product_count FROM products;
SELECT COUNT(*) AS category_count FROM categories;
SELECT COUNT(*) AS customer_count FROM customers;
SELECT COUNT(*) AS order_count FROM orders;
SELECT COUNT(*) AS order_item_count FROM order_items;
```

Note: A few products were deliberately left out of the `order_items` table so that you can identify items that were never purchased.

## Analysis tasks

Complete the following tasks using SQL. Wherever appropriate, use aliases and comments to make your queries easy to read. Many tasks require joining multiple tables or using aggregate functions. Unless explicitly stated, return only the requested columns.

### Task 1 — Total Revenue Check

Calculate the total revenue by summing quantity × unit_price across all rows in `order_items`. Compare this figure to the sum of `total_amount` in `orders` and confirm that they match. Return both values and their difference.

### Task 2 — Category‑level Sales

For each product category, compute:

- Total revenue (sum of quantity × unit_price)
- Total quantity sold
- Number of distinct products sold
- List the categories in descending order of revenue

### Task 3 — Top Products

Identify the five products with the highest revenue and the five products with the highest quantity sold. For each product, return the product name, category name, total revenue, and total quantity.

### Task 4 — Regional Performance

For each customer region, calculate the number of orders, total revenue, and average order value (use the `orders.total_amount` column). Order the results by average order value descending. Which region generates the highest average order value?

### Task 5 — Customer Lifetime Value

For every customer, compute:

- Total revenue (sum of their orders’ `total_amount`)
- Number of orders they have placed
- Average order value
- Return the top 10 customers by total revenue along with their names and region

### Task 6 — Monthly Sales Trend

Produce a summary table with one row per month showing the number of orders and total revenue. Indicate the month with the highest revenue. Also identify which product category contributed the most revenue in that month (hint: aggregate by month and category).

### Task 7 — New vs. Returning Customers

Classify each order based on the customer’s registration date:

- Orders placed within 30 days of registration are “new customer” orders
- Orders placed more than 30 days after registration are “returning customer” orders
- Count the number of orders and total revenue for each group

### Task 8 — Product Performance

- Identify products that were never ordered. Return the product name and its category.
- Identify products for which the average quantity per order exceeds 3 units. Return the product name, its category, and the average quantity.

### Task 9 — Order Size Categories

Create a derived column that classifies each order into:

- Small — `total_amount` < 100
- Medium — `total_amount` between 100 and 500
- Large — `total_amount` > 500
- Provide a summary showing the number of orders and total revenue in each category.

### Task 10 — Cross‑selling Analysis

Determine which pairs of products are most frequently purchased together. For every pair of products that appear in the same order, count the number of orders where the pair occurs. List the top five pairs by order count, along with the product names.

## Deliverables

- Data files — Import the contents of `sql_case_study_data.zip` into your database. The archive contains the five CSV files described above.
- SQL queries and results — Write and run queries to answer each question. Interpret your findings when necessary.

This case study will help you practice core SQL skills: joining tables, aggregating data, filtering using dates, ranking results, and deriving new categories from numeric data. Feel free to explore the dataset beyond these tasks to uncover other interesting insights!
