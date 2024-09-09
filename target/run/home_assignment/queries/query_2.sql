
  
    

        create or replace transient table home_assignment.public.query_2
         as
        (

SELECT TOP 5 raw_customer_data.name AS customer_name, SUM(transformed_sales_data.total_sales) AS total_sales
FROM transformed_sales_data
INNER JOIN raw_customer_data ON transformed_sales_data.customer_id = raw_customer_data.id
WHERE order_year = '2023'
GROUP BY customer_name
ORDER BY total_sales DESC
        );
      
  