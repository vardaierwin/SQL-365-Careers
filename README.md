# 📘 Extended Description (English)
## 🏢 Database Purpose & Structure
This database models an employee management system for a fictional company. It tracks employee details, salaries, job titles, department assignments, and managerial roles over time. The queries demonstrate a comprehensive range of SQL concepts: from basic data retrieval to advanced analytical techniques like **window functions, CTEs, subqueries, joins, aggregates, stored procedures, functions, triggers, indexes, views, and temporal data handling**.

The structure emphasizes historical tracking (salary and title changes over dates), making it ideal for HR analytics, salary trends, and organizational hierarchies.

## 🗃️ Tables Overview
* `employees`
Contains core employee information: `emp_no` (primary key), first/last name, birth date, gender, hire date. Serves as the central identity table for all employees.

* `salaries` Stores salary history: `emp_no` (foreign key to employees), salary amount, from_date, to_date. Tracks changes in compensation over time, with many-to-one relationship per employee.

* `titles` Job title history: `emp_no` (foreign key), `title`, `from_date`, `to_date`. Similar to salaries, it records promotions and role changes.

* `departments` Department metadata: `dept_no` (primary key), `dept_name`. Simple lookup table for organizational units.

* `dept_emp` Employee-department assignments: `emp_no` (foreign key), `dept_no` (foreign key), `from_date`, `to_date`. Many-to-many historical mapping between employees and departments.

* `dept_manager` Manager assignments: `emp_no` (foreign key), `dept_no` (foreign key), `from_date`, `to_date`.

Subset of dept_emp, focusing on managerial roles.
Additional tables created in queries: `departments_dup`, `dept_manager_dup`, `emp_manager` (for duplicates and custom scenarios), and temporary tables for analysis.

## ⚙️ SQL Features Demonstrated
### ✅ Basic Queries
`SELECT` with projections (`*` or specific columns), `WHERE` clauses for filtering (equality, `IN`, `NOT IN`, `LIKE` with wildcards `%`), date functions (`YEAR`, `CURDATE`), string functions (`LENGTH`), and logical operators (`AND`, `OR`).

Examples include filtering by names, hire dates, salary ranges, and pattern matching (`first_name LIKE 'mark%'`).

`DISTINCT` for unique values, `COUNT(*)` for totals, `ORDER BY` (`ASC/DESC`) for sorting, and `LIMIT` for pagination.

#### 🔄 Joins
* Inner joins (`JOIN`) between `employees`, `salaries`, `titles`, `dept_emp`, `dept_manager`, and `departments` (linking employees to managers or departments).
* Left joins (`LEFT JOIN`) for inclusive matching (all employees with optional manager details).
* Cross joins (`CROSS JOIN`) for Cartesian products (combining employees with all departments).
* Self joins (implicit via subqueries or explicit aliases) for comparisons within the same table.
* Multi-table joins to combine demographics, roles, salaries, and departments for complex reports.

#### 🧠 Aggregates & Analysis
Aggregation with `COUNT, SUM, AVG, MIN, MAX, ROUND` grouped by employee, title, department, or gender.

`GROUP BY` with `HAVING` for post-aggregate filtering (`average salary > 120000`).

`COALESCE, IFNULL` for handling `NULL`s and defaults.

`CASE` statements for conditional logic (categorizing salary raises as 'significant' or labeling employment status).

`UNION/UNION ALL` for combining result sets (top and bottom salaries).

Date manipulations with `DATEDIFF, DATE_SUB, DATE_ADD, CURDATE, NOW, DATE_FORMAT`.

#### 📈 Window Functions
`ROW_NUMBER()` for sequencing (by employee or salary order).

`RANK()` and `DENSE_RANK()` for ranking salaries within partitions (by department or employee).

`LAG/LEAD` for comparing previous/next values (salary differences over time).

`OVER (PARTITION BY ... ORDER BY ...)` clauses for analytical windows, including named windows (`WINDOW w AS ...`).

Examples include ranking managers by salary, calculating years from hire, and departmental salary rankings.

#### 📦 Common Table Expressions (CTEs)
`WITH` clauses for modular queries, such as:
* Counting names with filters.
* Gender-based salary comparisons (salaries below/above average).
* Highest/lowest salary extractions.
* Multi-CTE chains for average calculations and conditional counts.

#### 🧪 Subqueries
Nested queries in `WHERE` (`IN (SELECT ...)` for filtering managers hired in a range).

Correlated subqueries (average salary per employee via subquery in `SELECT`).

Subqueries in `FROM` for derived tables (ranking or `min/max` extraction).

Exists checks (employees with specific titles).

#### 🗃️ Temporary Tables & Views
`CREATE TEMPORARY TABLE` for inflation-adjusted salaries or date calculations.

`CREATE VIEW` for reusable queries (average manager salaries).

`CREATE TABLE` for duplicates (`departments_dup`) and custom tables (`emp_manager`).

`TRUNCATE, DROP` for cleanup.

#### 💾 Stored Procedures
`CREATE PROCEDURE` with `BEGIN/END` blocks, delimiters (`$$`).

Examples: Retrieving first 1000 rows, average salaries, parameterized employee info.

`CALL` to invoke, with output variables (`@emp_no`).

#### 🔧 Functions
`CREATE FUNCTION` (deterministic) for custom logic, like max salary by name or min/max/difference based on parameters.

Returns scalars (decimal for salary).

#### 🔔 Triggers
`CREATE TRIGGER` (`BEFORE INSERT`) to enforce rules, like setting `hire_date` to current if future-dated.

Uses variables (`DECLARE today DATE`).

#### 📇 Indexes
`CREATE INDEX` on salary, from_date, or composites for performance (`i_salary ON salaries(salary)`).

#### ⏰ Other Advanced Features
Global settings (`SET @@GLOBAL.sql_mode` to disable `ONLY_FULL_GROUP_BY`).

Events not directly shown, but scheduler-like concepts implied in date handling.

Temporary data insertion/deletion for testing (`INSERT`, `UPDATE`, `DELETE`).


Database Link: https://www.dropbox.com/scl/fi/cs4nvueufh97f1oi9592t/employees.sql?rlkey=im4n5ff00ik69g2nfugrwdhk4&e=1&dl=0
