# Data Engineering Home Assignment
The project involves maintaining the Snowflake setup, uploading and transforming data, and executing SQL queries to answer specific questions.
In order to execute the project, please follow the instructions below.

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
6. Verify Results
Check your Snowflake database to verify that queries have been executed.
