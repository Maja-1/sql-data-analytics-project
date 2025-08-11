# Data Analytics: An Exploratory Approach

This document provides an overview of the methodology for Exploratory Data Analysis (EDA) and advanced analytics. Through a series of steps, we will learn how to explore a database, understand its data structure, and extract meaningful insights.

![Project Roadmap](Project Roadmap.jpg)

---

### 1. Database Exploration

This step involves determining whether data points are **measures** or **dimensions**.

* A **dimension** is an attribute used to categorize and segment data (e.g., `Category`, `Products`, `Birthdate`, `ID`).
* A **measure** is a numerical value that can be aggregated (e.g., `Sales`, `Quantity`, `Age`).

To help distinguish them, ask these questions:
- Is the value a number?
- Does it make sense to aggregate it (sum, average, etc.)?

### 2. Dimensions Exploration

The goal is to identify the unique values within each dimension to understand how the data can be grouped.

- The `DISTINCT()` function is used, e.g., `DISTINCT Country`, `DISTINCT Category`, `DISTINCT Product`.

### 3. Date Exploration

We analyze the time scope of the data by finding the earliest and latest dates.

- The `MIN()` and `MAX()` functions are used, e.g., `MIN(order_date)`, `MAX(create_date)`.

### 4. Measures Exploration

We calculate the business's key metrics ("Big Numbers") at the highest level of aggregation.

- Aggregation functions such as `SUM()`, `AVG()`, `COUNT()` are used, e.g., `AVG(price)`, `SUM(Sales)`, `SUM(Quantity)`.

### 5. Magnitude

We compare measure values by categories to understand the importance of each category.

- Aggregation by dimension is used, e.g., `SUM(Sales) BY Country`, `SUM(Quantity) BY Category`.
- **Joining Tables**: We start with the Fact table and then `LEFT JOIN` the dimension tables.
- **Cardinality**:
    - **Low Cardinality**: A small number of unique values (e.g., `Country`, `Gender`).
    - **High Cardinality**: A large number of unique values (e.g., `Product`, `Customer`, `Address`).

---

### 6. Ranking

We order dimension values by measures to identify top and bottom performers.

- `GROUP BY` and `TOP N` are used for simple tasks.
- **WINDOW functions** (`RANK()`, `DENSE_RANK()`, `ROW_NUMBER()`) are useful for more complex queries.

### 7. Change over Time Analysis

We track how a measure evolves over time, identifying trends and seasonality.

- **Example**: `SUM(Sales) BY Year`, `AVG(Cost) BY Month`.

### 8. Cumulative Analysis

We progressively aggregate data over time to understand the business's overall growth or decline.

- **Example**: `Running Total Sales BY Year`, `Moving Average of Sales BY Month`.

### 9. Performance Analysis

We compare the current value to a target, average, or previous period's value.

- **Example**: `Current Year Sales - Previous Year Sales` (YOY), `Current Sales - Average Sales`.
- **WINDOW functions** are also used here.

### 10. Part-to-Whole

We analyze the contribution of an individual part to the overall value, which helps us understand which category has the greatest business impact.

- **Formula**: `([Measure] / Total[Measure]) * 100 BY [Dimension]`
- **Example**: `(Sales / Total Sales) * 100 BY Category`.
- **WINDOW functions** are useful for displaying aggregations at multiple levels.

### 11. Data Segmentation

We group data based on specific ranges, often using `CASE WHEN` statements.

- **Example**: `Total Products By Sales Range`, `Total Customers By Age`.

### 12. Reporting

We use **CTE (Common Table Expressions)** to organize complex queries and aggregate metrics at the customer or other entity level. CTEs are used for:

1.  Joining tables and selecting necessary columns.
2.  Calculating aggregated metrics (total orders, total sales, lifespan, etc.).

### 🛠️ **Best Practices for Table Joins**

A structured approach to joining tables ensures accuracy and efficiency.
1.  **Identify Required Tables:** Start by determining which tables contain the necessary data.
2.  **Select Columns:** Define the specific columns you need for your analysis.
3.  **Perform Joins:** Execute the join operations, typically starting with a central fact table.
4.  **Apply Aggregations:** Perform aggregations on the selected columns to produce the final results.
