# Data Engineering Home Assignment
The project includes maintenance of the Snowflake setup, data upload and transformation, and SQL queries answering the questions.

## Installation and usage
1. Log into your Snowflake account.
2. Clone the repository to your local machine.
3. Update the profiles.yml file by adding your credentials and move it to your ~/.dbt
4. Navigate to your project directory and check connection via
```sql
dbt debug
```
5. Run the project via
```sql
dbt run
```
6. Run the queries using the provided .sql files in the queries/ folder, e.g.
```sql
snowsql -f queries/query_1.sql
```
