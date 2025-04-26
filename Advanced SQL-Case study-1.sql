-- Case Study --> Advanccd SQL

-- Synergizing Success: Improving Operational Efficiency and Employee Engagement

-- Step 1: Create a database for the project
CREATE DATABASE BusinessOperationsDB;
GO

-- Step 2: Use the database
USE BusinessOperationsDB;
GO

-- Step 3: Create a table matching the CSV structure
CREATE TABLE BusinessOperations (
    company_id INT,
    department VARCHAR(100),
    employee_id INT,
    employee_name VARCHAR(100),
    role VARCHAR(100),
    salary DECIMAL(10,2),
    tenure INT,
    training_completed BIT,
    performance_score DECIMAL(5,2),
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(100),
    customer_feedback_score DECIMAL(5,2),
    units_sold INT,
    revenue DECIMAL(18,2),
    profit_margin DECIMAL(5,2),
    inventory_level INT,
    reorder_point INT,
    supplier_id INT,
    supplier_name VARCHAR(100)
);

/*
Step 2: Solve Case Study Questions

Problem Statement:

Enhancing Operational Efficiency and Growth Strategies in a Multi-Departmental
Business

Context:
? Business operations involve a complex interaction between departments,
products, suppliers, and employees, where each element contributes to
overall performance. Challenges such as managing inventory levels,
optimizing employee performance, maintaining customer satisfaction, and
navigating supply chain dependencies require constant data analysis for
informed decision-making. Effective alignment between leadership,
employees, and market trends is also crucial for future planning and
sustainable growth.

Problem:

? The company is experiencing several operational inefficiencies:
? Employee Performance & Retention Challenges: Inconsistent employee
performance and high turnover rates negatively impact productivity. The
company needs to evaluate whether training programs, salary, and tenure
influence employee retention and performance.
? Product Sales & Customer Satisfaction Issues: Some products have low
customer feedback scores despite high sales, indicating potential quality or
support issues. Additionally, low sales for certain products may suggest
gaps in marketing strategies or misalignment with market demands.
? Supply Chain & Inventory Management Issues: Supply chain risks are
posed by low inventory levels approaching reorder points, potentially
leading to missed sales opportunities if not addressed promptly
? Technology Usage & Future Planning Concerns: The company is
underutilizing technology in several departments, leading to inefficiencies.
Weak market research and unclear company direction could affect
long-term growth and competitiveness.


DataSet :
? https://drive.google.com/file/d/1LcbxWSQrTjYbEyJuFqLf487_fYZR9Osm/view?usp=sharing
Analysis Questions:


? Employee Performance:

? Which department had the highest average profit margin among its
products?
? Which employee in the IT department had the highest performance score,
and what was their role?

? Product Sales & Customer Satisfaction:

? Identify the product with the highest revenue generated in the HR
department.
? What is the average customer feedback score for products in the
Accessories category, and which product received the highest score?

? Supply Chain & Inventory Management:

? Which supplier had the highest total inventory level across all
departments?
? Which product in the Gadgets category had the lowest inventory level?

? Employee Training & Sales:

? How many employees in the Sales department have completed training
programs, and what percentage does this represent of the total employees
in that department?

Product Sales Contribution:? What is the total number of units sold for all products in the Marketing
department, and which product contributed the most to this total?



2.1 Employee Performance

Q1. Which department had the highest average profit margin among its products?
*/

-- Finding department with the highest average profit margin
SELECT TOP 1
    department,
    AVG(profit_margin) AS avg_profit_margin
FROM BusinessOperations
GROUP BY department
ORDER BY avg_profit_margin DESC;

/*
 Explanation:

Group by department.

Calculate average profit margin.

Pick the top department with the highest. */

-- Q2. Which employee in the IT department had the highest performance score, and what was their role?


-- Finding top performing employee in IT department
SELECT TOP 1
    employee_name,
    employee_role,
    employee_performance_score
FROM BusinessOperations
WHERE department = 'IT'
ORDER BY employee_performance_score DESC;

/*
 Explanation:

Filter only IT department.

Find employee with highest performance score.

2.2 Product Sales & Customer Satisfaction

Q3. Product with the highest revenue generated in the HR department?
*/

-- Finding the product with the highest revenue in HR department
SELECT TOP 1
    product_name,
    revenue
FROM BusinessOperations
WHERE department = 'HR'
ORDER BY revenue DESC;

-- Q4. Average customer feedback score for Accessories category & highest scored product

-- Finding average feedback score for Accessories and product with highest score

-- Step 1: Average customer feedback
SELECT
    AVG(customer_feedback_score) AS avg_feedback_score
FROM BusinessOperations
WHERE category = 'Accessories';

-- Step 2: Product with highest feedback
SELECT TOP 1
    product_name,
    customer_feedback_score
FROM BusinessOperations
WHERE category = 'Accessories'
ORDER BY customer_feedback_score DESC;

-- 2.3 Supply Chain & Inventory Management

--Q5. Supplier with highest total inventory

-- Finding supplier with the highest total inventory
SELECT TOP 1
    supplier_name,
    SUM(inventory_level) AS total_inventory
FROM BusinessOperations
GROUP BY supplier_name
ORDER BY total_inventory DESC;


-- Q6. Product in Gadgets category with lowest inventory


-- Finding product with lowest inventory in Gadgets category
SELECT TOP 1
    product_name,
    inventory_level
FROM BusinessOperations
WHERE category = 'Gadgets'
ORDER BY inventory_level ASC;

-- 2.4 Employee Training & Sales
-- Q7. Number and % of Sales employees who completed training


-- Finding training completion status in Sales department
-- Step 1: Total employees
SELECT
    COUNT(*) AS total_sales_employees
FROM BusinessOperations
WHERE department = 'Sales';

-- Step 2: Employees who completed training
SELECT
    COUNT(*) AS trained_sales_employees
FROM BusinessOperations
WHERE department = 'Sales' AND training_program_completed = 1;

-- Step 3: Percentage calculation
SELECT
    (CAST(SUM(CASE WHEN training_program_completed = 1 THEN 1 ELSE 0 END) AS FLOAT) /
     COUNT(*)) * 100 AS training_completion_percentage
FROM BusinessOperations
WHERE department = 'Sales';

/*
 Explanation:

First count total Sales employees.

Then count how many completed training.

Then calculate %.
*/

-- 2.5 Product Sales Contribution
-- Q8. Total units sold in Marketing & product contributing most


-- Finding total units sold and top contributing product in Marketing department

-- Step 1: Total units sold
SELECT
    SUM(units_sold) AS total_units_sold
FROM BusinessOperations
WHERE department = 'Marketing';

-- Step 2: Product contributing most
SELECT TOP 1
    product_name,
    units_sold
FROM BusinessOperations
WHERE department = 'Marketing'
ORDER BY units_sold DESC;



-- Step 3: Advanced SQL Tasks

/*
Advanced SQL Questions

? Write a query to rank employees in each department by their revenue
generated using a window function.
? Create a CTE to find the average salary of employees in each department
and then select departments where the average salary is above $70,000.
? Create a view that shows only the product name, revenue, and profit
margin for products in the Accessories category.
? Write a query to create a non-clustered index on the employee_name
column to improve query performance.
? Create a stored procedure that accepts a department name as a
parameter and returns the total revenue generated by that department.
? Write a trigger that logs changes to the revenue column in a separate table
whenever an update occurs.
? Create a scalar UDF that calculates the profit from a given product's
revenue and profit margin.
? Provide a query to create a clustered index on the company_id column
*/


-- 3.1 Ranking employees by revenue in each department

-- Ranking employees based on revenue inside their departments
SELECT
    employee_name,
    department,
    revenue,
    RANK() OVER (PARTITION BY department ORDER BY revenue DESC) AS revenue_rank
FROM BusinessOperations;

-- 3.2 CTE to find average salary > $70,000

-- Common Table Expression to find departments with average salary > 70000
WITH DeptAvgSalary AS (
    SELECT
        department,
        AVG(salary) AS avg_salary
    FROM BusinessOperations
    GROUP BY department
)
SELECT
    department,
    avg_salary
FROM DeptAvgSalary
WHERE avg_salary > 70000;

-- 3.3 View for Accessories category (Product name, revenue, profit margin)

-- Creating a view for Accessories category
CREATE VIEW AccessoriesProducts AS
SELECT
    product_name,
    revenue,
    profit_margin
FROM BusinessOperations
WHERE category = 'Accessories';

-- 3.4 Create Non-Clustered Index

-- Creating a non-clustered index on employee_name
CREATE NONCLUSTERED INDEX idx_employee_name
ON BusinessOperations (employee_name);

-- 3.5 Stored Procedure for Department Revenue

-- Stored procedure to return total revenue for a given department
CREATE PROCEDURE GetDepartmentRevenue
    @DepartmentName VARCHAR(100)
AS
BEGIN
    SELECT
        department,
        SUM(revenue) AS total_revenue
    FROM BusinessOperations
    WHERE department = @DepartmentName
    GROUP BY department;
END;


-- 3.6 Trigger to log changes to revenue
-- First, create a log table:


-- Log table to store revenue changes
CREATE TABLE RevenueChangeLog (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    employee_id INT,
    old_revenue DECIMAL(18,2),
    new_revenue DECIMAL(18,2),
    change_date DATETIME DEFAULT GETDATE()
);

--Then the trigger:

-- Trigger to log revenue changes
CREATE TRIGGER trg_RevenueChange
ON BusinessOperations
AFTER UPDATE
AS
BEGIN
    INSERT INTO RevenueChangeLog (employee_id, old_revenue, new_revenue)
    SELECT
        d.employee_id,
        d.revenue,
        i.revenue
    FROM
        deleted d
    INNER JOIN
        inserted i ON d.employee_id = i.employee_id
    WHERE
        d.revenue <> i.revenue;
END;


-- 3.7 Scalar UDF for calculating Profit

-- User Defined Function to calculate profit
CREATE FUNCTION CalculateProfit
(
    @Revenue DECIMAL(18,2),
    @ProfitMargin DECIMAL(5,2)
)
RETURNS DECIMAL(18,2)
AS
BEGIN
    RETURN @Revenue * (@ProfitMargin / 100);
END;


-- 3.8 Create Clustered Index on company_id

-- Creating a clustered index on company_id
CREATE CLUSTERED INDEX idx_company_id
ON BusinessOperations (company_id);