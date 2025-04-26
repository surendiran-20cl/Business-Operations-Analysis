# Business Operations Analysis — SQL Capstone Project

## Project Overview

This project aims to enhance operational efficiency, employee engagement, and future growth strategies by performing comprehensive data analysis on a multi-departmental business operations dataset. The project extensively uses SQL Server Management Studio (SSMS) to explore employee performance, product sales, customer satisfaction, inventory management, and supply chain efficiency.

The project combines fundamental SQL operations with advanced techniques like Common Table Expressions (CTEs), window functions, views, stored procedures, user-defined functions (UDFs), and triggers to deliver actionable business insights.

---

## Dataset

**Dataset Name**: Business_Operations_Dataset.csv

**Dataset Fields**:
- company_id
- department
- employee_id
- employee_name
- role
- salary
- tenure
- training_completed
- performance_score
- product_id
- product_name
- category
- customer_feedback_score
- units_sold
- revenue
- profit_margin
- inventory_level
- reorder_point
- supplier_id
- supplier_name

---

## Business Problems Addressed

- Identify departments and employees contributing highest profit margins and performance.
- Analyze product sales and customer feedback to optimize marketing and quality strategies.
- Highlight inventory risks and supplier dependencies to strengthen supply chain management.
- Evaluate the impact of employee training programs on sales performance.
- Support long-term technology and strategic planning through operational insights.

---

## Technical Approach

### Database Setup
- Created `BusinessOperationsDB` database.
- Designed `BusinessOperations` table matching the dataset structure.
- Imported data using SQL Server Import Wizard.

### Data Analysis (Basic SQL Queries)
- Aggregated performance metrics by department.
- Identified top-performing employees within departments.
- Analyzed revenue distribution across departments and products.
- Calculated inventory vulnerabilities and supplier performance.

### Advanced SQL Techniques
- **Window Functions**: Ranked employees by revenue within each department.
- **CTEs**: Calculated average salaries and filtered high-paying departments.
- **Views**: Created simplified views for specific product category insights.
- **Stored Procedures**: Automated revenue reporting for specific departments.
- **Triggers**: Logged revenue changes automatically for audit purposes.
- **User Defined Functions (UDFs)**: Created scalar functions for dynamic profit calculations.
- **Indexes**:
  - Created a non-clustered index on `employee_name` for faster lookups.
  - Created a clustered index on `company_id` for table optimization.


---

## Key SQL Concepts Used

- DDL (Data Definition Language) and DML (Data Manipulation Language)
- Aggregate Functions: `AVG()`, `SUM()`
- Sorting and Grouping: `GROUP BY`, `ORDER BY`
- Filtering: `WHERE`, `HAVING`
- Window Functions: `RANK() OVER (PARTITION BY...)`
- Common Table Expressions (CTEs)
- Views and Indexes
- Stored Procedures and Triggers
- User-Defined Functions (UDFs)

---

## Tools and Technologies

- Microsoft SQL Server Management Studio (SSMS)
- SQL Server Database Engine
- SQL Server Import and Export Wizard
- CSV Data Handling

---

## How to Run

1. Clone this repository.
2. Open MS SQL Server Management Studio.
3. Run `01_CreateDatabase.sql` and `02_CreateTable.sql`.
4. Import `Business_Operations_Dataset.csv` using the Import Wizard.
5. Execute `04_AnalysisQueries.sql` for data analysis results.
6. Execute `05_AdvancedTasks.sql` for advanced database operations.
7. Review project explanations in `06_ProjectDocumentation.docx`.

---

## License

This project is developed as part of an educational SQL Capstone program and is free to use for learning purposes.

---
