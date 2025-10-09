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

-- Which categories contribute the most to overall orders?
WITH category_sales AS(
SELECT
p.category,
COUNT(DISTINCT f.order_number) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.category)

SELECT
category,
total_orders,
SUM(total_orders) OVER () AS overall_orders,
CONCAT(ROUND((CAST(total_orders AS FLOAT) /SUM(total_orders) OVER ())*100, 2), '%')  AS per_of_total
FROM category_sales
ORDER BY total_orders DESC


/*
Accessories is the most popular product category, making up the largest share of sales with 44.55% of the total orders. 
Bikes follow as the second most important category, accounting for a significant 37.2% of all orders. The Clothing category 
has the smallest contribution at only 18.25%, suggesting it is an area that might need attention to boost sales. Overall, 
the majority of the 40,874 total orders are focused on Accessories and Bikes (almost 82%), which are the core drivers of 
the business.
*/

WITH category_sales AS(
SELECT
p.category,
COUNT(DISTINCT f.customer_key) AS total_customers
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.category)

SELECT
category,
total_customers,
SUM(total_customers) OVER () AS overall_customers,
CONCAT(ROUND((CAST(total_customers AS FLOAT) /SUM(total_customers) OVER ())*100, 2), '%')  AS per_of_total
FROM category_sales
ORDER BY total_customers DESC

/*Customer base is primarily focused on buying accessories, followed by bikes. Purchases in the clothing category are the 
lowest.
This data suggests that efforts to increase sales could focus on:
Maintaining the success of Accessories.
Developing strategies to boost customer engagement and sales within the Clothing category.*/



/*
What Each Product Category Means for the Business
Analysis of Sales Amount, Total Orders, and Total Customers shows that product categories play very different roles 
in business.

Key Takeaways 
1. Bikes: The Money-Maker 
Financial Impact: Bikes bring in almost all the money, accounting for 96.46% of total sales.
Insight: These are most expensive products (high value) and the main driver of revenue. 
The company’s financial success heavily relies on selling bikes.

2. Accessories: The People-Gatherer (Volume and Reach) 
Customer Traffic: Accessories generate the highest volume of transactions, bringing in 44.55% of all orders and nearly half 
of total customers (48.60%).
Insight: These are likely lower-priced items that people buy frequently or use as a first purchase. Accessories are crucial 
for attracting new customers and keeping customer base engaged.

3. Clothing: The Growth Opportunity 🌱
Lowest Contribution: Clothing contributes the least to sales (1.16%), orders (18.25%), and customers (22.03%).
Insight: While the revenue is low, the percentage of customers who buy clothing (22.03%) is higher than the sales 
contribution. This suggests there is a dedicated customer base, but these customers aren't spending much on clothes yet. 
This is the category with the most potential to grow if you can increase the average purchase value.

Recommendations for Action 
Based on these findings, here is what should focus on:

Protect Bike Sales: Give the Bikes category top priority for marketing, inventory, and customer service. They are the
main income.

Upsell Accessories Buyers: Since Accessories bring in the most people, focus on strategies like "cross-selling" (offering a 
related product) or "up-selling" (offering a more expensive product) to get these customers to buy a bike later.

Boost Clothing Revenue: Find ways to make Clothing purchases more valuable. Try grouping (bundling) clothing with bikes or 
accessories to increase the overall order size.

In simple terms: Bikes make the money, Accessories bring in the people, and Clothing has the biggest potential for future 
growth.
*/

