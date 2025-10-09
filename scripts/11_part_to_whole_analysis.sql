/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing or regional comparisons.

SQL Functions Used:
    - SUM(), AVG(): Aggregates values for comparison.
    - Window Functions: SUM() OVER() for total calculations.
===============================================================================
*/
-- Which categories contribute the most to overall sales?
WITH category_sales AS (
    SELECT
        p.category,
        SUM(f.sales_amount) AS total_sales
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON p.product_key = f.product_key
    GROUP BY p.category
)
SELECT
    category,
    total_sales,
    SUM(total_sales) OVER () AS overall_sales,
    ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER ()) * 100, 2) AS percentage_of_total
FROM category_sales

ORDER BY total_sales DESC;

/*
The analysis clearly shows that Bikes dominate the total sales, accounting for a massive 96.46% of all revenue.
This means the other categories, Accessories (2.39%) and Clothing (1.16%), contribute very little to the overall sales 
figure.

Key Takeaway
The company's performance is almost entirely dependent on the Bikes category. For future growth and stability, 
we should investigate why Accessories and Clothing have such low sales. We could explore strategies like better marketing,
product bundling, or inventory adjustments to boost their contribution.
For Better Marketing, the key is to run special campaigns that only show Accessories and Clothing to make people more aware 
of those items. Next, Product Bundling means you offer a discount on an Accessory or Clothing item when a customer buys a 
Bike, which helps increase the total money spent per customer. Finally, Inventory Adjustments requires you to order more of 
the products that sell well and stop buying the slow-selling items to make the categories more profitable overall.

*/
