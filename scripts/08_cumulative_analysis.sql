/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/

-- Calculate the total sales per month 
-- and the running total of sales over time 
SELECT
	order_date,
	total_sales,
	SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
	AVG(avg_price) OVER (ORDER BY order_date) AS moving_average_price
FROM
(
    SELECT 
        DATETRUNC(year, order_date) AS order_date,
        SUM(sales_amount) AS total_sales,
        AVG(price) AS avg_price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(year, order_date)
) t

/*
The cumulative (running total) sales show strong, consistent growth, increasing 
from $43,419 in December 2010 to over $29 million by January 2014, indicating a 
very successful overall business expansion. However, this growth has occurred 
alongside a continuous and significant decline in the average sales price (the 
moving average price), which dropped from $$$3,101 to $1,745.

This suggests the company's revenue growth is primarily driven by selling a much 
higher volume of units, potentially through lower pricing strategies, discounted 
sales, or a shift in the sales mix towards less expensive products.
*/
