{{ config(materialized='table') }}

SELECT TOP 5 product_name, SUM(total_sales) AS total_sales
FROM transformed_sales_data
WHERE order_year = '2023'
GROUP BY product_name
ORDER BY total_sales DESC