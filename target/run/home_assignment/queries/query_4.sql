
  
    

        create or replace transient table home_assignment.public.query_4
         as
        (

SELECT TOP 1 raw_customer_data.name AS customer_name, SUM(transformed_sales_data.total_sales) AS october_sales 
FROM transformed_sales_data
INNER JOIN raw_customer_data ON transformed_sales_data.CUSTOMER_ID = raw_customer_data.id
WHERE order_year = '2023' AND order_month = '10'
GROUP BY name
        );
      
  