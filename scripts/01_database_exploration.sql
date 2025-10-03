/*
===============================================================================
Database Exploration
===============================================================================
Purpose:
    - To explore the structure of the database, including the list of tables and their schemas.
    - To inspect the columns and metadata for specific tables.

Table Used:
    - INFORMATION_SCHEMA.TABLES
    - INFORMATION_SCHEMA.COLUMNS
===============================================================================
*/

-- Retrieve a list of all tables in the database
SELECT 
    TABLE_CATALOG, 
    TABLE_SCHEMA, 
    TABLE_NAME, 
    TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES;




/*
Data Layers (Schemas)

bronze (Rows 1-6): These six objects are all BASE TABLEs. This schema holds raw, source-system data, often with minimal cleanup or transformation. They are the initial ingestion point.

Examples: crm_cust_info, crm_prd_info, crm_sales_details, erp_loc_a101, erp_cust_az12, erp_px_cat_g1v2.

silver (Rows 7-12): These six objects are also BASE TABLEs. This layer typically contains cleansed, conformed, and integrated data. It's the "single source of truth" where data from different sources (like the bronze tables) has been standardized and combined.

Examples: crm_cust_info, crm_prd_info, crm_sales_details, erp_loc_a101, erp_cust_az12, erp_px_cat_g1v2. (Note: The table names are the same as in bronze, suggesting these are the clean versions of the raw data).

gold (Rows 13-15): These three objects are VIEWs. This final layer contains highly refined, aggregated, and business-ready data, usually structured into dimensional models (Star or Snowflake schemas) for analytics and reporting.

Examples: dim_customers (Dimension), dim_products (Dimension), fact_sales (Fact). The VIEW type indicates these models are built on top of the underlying silver tables.
*/


-- Retrieve all columns for a specific table (dim_customers)
SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    IS_NULLABLE, 
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';

/*
Key Observations for dim_customers:

Primary Keys: customer_key is a bigint and is NOT NULL, it is the Surrogate Key (primary key) used to uniquely identify customers in the dimension table.

Business Keys: customer_number is an int and is NOT NULL. This is the Business Key, the original ID from the source system.

Mandatory Fields: customer_key, customer_number, birthdate, and create_date are all defined as NOT NULL, meaning every customer record must have a value for these fields.

Text Fields: Columns like first_name, last_name, country, marital_status, and gender are nvarchar(50), indicating they store Unicode strings up to 50 characters long and are NULLABLE (optional).
*/
