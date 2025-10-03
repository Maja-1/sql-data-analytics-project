
/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	- Identify the unique values (or categories) in each dimension
	- Recognized how data might be grouped or segmented, which is useful for later analysis
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/

-- Retrieve a list of unique countries from which customers originate
SELECT DISTINCT 
    country 
FROM gold.dim_customers
ORDER BY country;

/*
The list clearly outlines your current geographic reach, identifying seven distinct countries from which your customers originate:

Canada, United States, France, Germany, United Kingdom, Australia.

*/


-- Retrieve a list of unique categories, subcategories, and products
SELECT DISTINCT 
    category, 
    subcategory, 
    product_name 
FROM gold.dim_products
ORDER BY category, subcategory, product_name;

/*
This query listed the unique combinations of categories, subcategories, and products from the gold.dim_products 
table. Four primary product categories were identified: Accessories, Bikes, Clothing, and Components. The Bikes category is 
the most extensive, featuring three subcategories (Mountain, Road, Touring) with numerous products differentiated by color 
and size. Components includes the largest number of subcategories, such as Brakes, Forks, Frames, and Wheels, while 
Accessories and Clothing are also highly segmented. A small group of products, notably various Pedals, were also found 
but are currently listed without an assigned category or subcategory (NULL values).

*/
