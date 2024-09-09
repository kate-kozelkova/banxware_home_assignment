
  
    

        create or replace transient table home_assignment.public.query_3
         as
        (

SELECT order_month, AVG(total_sales) as avg_sales
FROM transformed_sales_data
WHERE order_year = '2023'
GROUP BY order_month
ORDER BY order_month ASC
        );
      
  