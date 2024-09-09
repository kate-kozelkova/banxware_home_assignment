# Project structure

- [Setup](#1-setup) 
- [Data Loading & Initial Exploration](#2-data-loading--initial-exploration)
- [Data Transformation](#3-data-transformation)
- [SQL Queries & Output](#4-sql-queries--output)

## 1. Setup
### Snowflake Connection Configuration
As the first step, we had to set up a Snowflake environment. To do this, after creating an account, we set up a home_assignment database, downloaded the repository, create a profiles.yml file with corresponding credentials from our account in ~/.dbt, and establish connection with our Snowflake system via cmd.

## 2. Data Loading & Initial Exploration

### Loading Raw Data
Having established connection with Snowflake, we proceed to injecting the required data. As recommended, we used seed for this purpose: after moving csv files to the seed folder on our PC, we run dbt seed that loads them into our data warehouse. As a result, we have two tables - raw_sales_data and raw_customer_data

## 3. Data Transformation

### Creating transformed_sales_data
We transform raw_sales_data with the following query:
```sql
    CREATE TABLE transformed_sales_data AS
    SELECT *, quantity * price AS total_sales, EXTRACT(YEAR FROM TO_DATE(order_date, 'MM/DD/YYYY')) AS order_year, EXTRACT(MONTH FROM TO_DATE(order_date, 'MM/DD/YYYY')) AS order_month, EXTRACT(DAY FROM TO_DATE(order_date, 'MM/DD/YYYY')) AS order_day
    FROM raw_sales_data;
```

We choose all the columns from raw_sales_data, calculate a new one 'total_sales' by multiplying values from 'quantity' and 'price', and also split 'order_date' into 'order_day', 'order_month', and 'order_day' by extracting corresponding date attributes. We save the output as a new table in our public schema of the home_assignment database.

## 4. SQL queries & Output

### Answering the questions with SQL queries

*1. What are the top 5 products by total sales amount in the year 2023?*

| PRODUCT_NAME | TOTAL_SALES |
|--------------|-------------|
| Product_3001 | 872.28      |
| Product_3008 | 757.60      |
| Product_3001 | 757.36      |
| Product_3003 | 699.04      |
| Product_3008 | 657.86      |

SQL query:
```sql
    SELECT TOP 5 product_name, SUM(transformed_sales_data.total_sales) AS total_sales
    FROM transformed_sales_data
    WHERE order_year = '2023'
    GROUP BY product_name
    ORDER BY total_sales DESC;
```

We return names and sales amount of top 5 products in the descending order based on their total sales in 2023 using data from transformed_sales_data and by summarising sales based on the product name.

*2. What are the names of the top 5 customers by total sales amount in the year 2023?*

| CUSTOMER_NAME | TOTAL_SALES |
|---------------|-------------|
| 0Ck7rIvcqI	| 1318.43     |
| KlqmuPHoZ5	| 1246.16     |
| j7lXV1P2Mo	| 1141.54     |
| LiLQy22BYT	| 1038.73     |
| miTbp86xy6	| 957.79      |

```sql
    SUM(transformed_sales_data.total_sales) AS total_sales 
    FROM transformed_sales_data
    INNER JOIN raw_customer_data ON transformed_sales_data.customer_id = raw_customer_data.id
    WHERE order_year = '2023'
    GROUP BY customer_name
    ORDER BY total_sales DESC;
```

We return names and sales amount of top 5 customers with the highest purchase volume, based on their total purchases in 2023 by joining raw_customer_data and transformed_sales_data on customer ID.

*3. What is the average order value for each month in the year 2023?*

| ORDER_MONTH | AVG_SALES    |
|-------------|--------------|
| 1		      | 216.698571429|
| 2	          | 196.921818182|
| 3	          | 226.168      |
| 4	          | 227.07       |
| 5	          | 257.895      |
| 6		      | 300.928571429|
| 7	          | 345.146      |
| 8	          | 310.80125    |
| 9	          | 241.670833333|
| 10	      | 164.674285714|
| 11	      | 192.938888889|
| 12	      | 281.7575     |

```sql
SELECT order_month, AVG(total_sales) as avg_sales
FROM transformed_sales_data
WHERE order_year = '2023'
GROUP BY order_month
ORDER BY order_month ASC;
```

We return month numbers and corresponding average sales amounts, summarised based on the month number.

*4. Which customer had the highest order volume in the month of October 2023?*

| CUSTOMER_NAME| TOTAL_SALES  |
|--------------|--------------|
| x4vcs5xPrM   | 89.31        |

```sql
SELECT TOP 1 raw_customer_data.name AS customer_name, SUM(transformed_sales_data.total_sales) AS october_sales 
FROM transformed_sales_data
INNER JOIN raw_customer_data ON transformed_sales_data.CUSTOMER_ID = raw_customer_data.id
WHERE order_year = '2023' AND order_month = '10'
GROUP BY name
```

We return the customer name with the highest total urchase amount in October by joining transformed_sales_data and raw_customer_data on customer ID and summarising total_sales based on the customer name.