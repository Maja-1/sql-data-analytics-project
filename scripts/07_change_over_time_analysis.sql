/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/

-- Analyse sales performance over time
-- Quick Date Functions
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);

/*
2013 was the most successful year because the company brought in the most customers and made the most money. 
This record high was likely built on selling a very large quantity of lower-priced items. However, sales completely 
collapsed in 2014, wiping out all the recent growth. 

gold addditional We must immediately investigate the cause of the 2014 failure 
and understand what exactly was sold during the 2013 boom.

Monthly report
This data shows a clear growth trend in sales throughout the year, peaking in the last two months. 
December was the strongest month, with the highest total sales ($3,211,396) and the largest number of customers (2,656). 
The increase in sales seems to be driven by more customers buying more items, particularly during the holiday shopping 
season in the final quarter. This suggests that marketing efforts are most effective late in the year, and the company 
should look for ways to boost sales in the earlier, slower months.
*/

-- DATETRUNC()
SELECT
    DATETRUNC(month, order_date) AS order_date,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
ORDER BY DATETRUNC(month, order_date);

-- FORMAT()
SELECT
    FORMAT(order_date, 'yyyy-MMM') AS order_date,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MMM')
ORDER BY FORMAT(order_date, 'yyyy-MMM');


