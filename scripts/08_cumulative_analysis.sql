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
This business is doing very well overall. Total sales have grown hugely, increasing from about $43,000 in late 2010 to over 
$29 million by 2014. This shows successful business growth.

However, we see a clear trade-off:

As total sales went up, the average price of what we sold went down dramatically, dropping from about $3,100 to $1,745.

This means that the big increase in revenue is likely because we are selling many more items—not because we are selling 
items at a higher price. We might be using lower prices, more discounts, or selling more cheap products to drive this 
high volume.
*/

