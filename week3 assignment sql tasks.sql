-- InternNova - Week 3 Assignment - Database Setup
-- SQL Database and Sample Data Setup

CREATE DATABASE IF NOT EXISTS internnova_week3_assignment;
USE internnova_week3_assignment;

DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Products;

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    department_id INT NOT NULL,
    hire_date DATE NOT NULL,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(80) NOT NULL,
    category VARCHAR(40) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
);

INSERT INTO Departments (department_id, department_name) VALUES
(1, 'Sales'),
(2, 'IT'),
(3, 'HR'),
(4, 'Marketing'),
(5, 'Finance');

INSERT INTO Employees (employee_id, employee_name, salary, department_id, hire_date) VALUES
(101, 'Alice Sharma', 68000.00, 1, '2022-02-15'),
(102, 'Bob Mehta', 52000.00, 2, '2023-06-10'),
(103, 'Carol Singh', 91000.00, 1, '2021-08-21'),
(104, 'David Kumar', 60000.00, 3, '2024-01-12'),
(105, 'Eva Kapoor', 75000.00, 2, '2022-11-03'),
(106, 'Farhan Ali', 47000.00, 4, '2024-04-18'),
(107, 'Grace Nair', 83000.00, 1, '2023-03-27'),
(108, 'Hari Rao', 56000.00, 2, '2025-01-09');

INSERT INTO Products (product_id, product_name, category, unit_price) VALUES
(201, 'Laptop Pro 14', 'Electronics', 850.00),
(202, 'Wireless Mouse', 'Accessories', 25.00),
(203, 'Mechanical Keyboard', 'Accessories', 75.00),
(204, '27-inch Monitor', 'Electronics', 320.00),
(205, 'USB-C Hub', 'Accessories', 45.00),
(206, 'Office Chair', 'Furniture', 220.00),
(207, 'Standing Desk', 'Furniture', 480.00),
(208, 'Noise-Cancel Headset', 'Electronics', 110.00);

select * from employees;
select * from departments;
select * from products;

-- SQL Tasks
-- Run the database setup file first, then select the internnova_week3_assignment.

-- TASK 1: Introduction to Databases & SELECT Statement
-- 1A. Display all records.
SELECT * FROM Employees;

-- 1B. Select specific columns and use aliases.
SELECT employee_name AS Employee,
       salary AS Annual_Salary,
       department_id AS Department_ID
FROM Employees
ORDER BY employee_id;

-- TASK 2: WHERE, ORDER BY & Aggregate Functions
-- 2A. Filter employees earning at least 60,000 and sort from highest to lowest.
SELECT employee_id, employee_name, salary, department_id
FROM Employees
WHERE salary >= 60000
ORDER BY salary DESC;

-- 2B. Use COUNT, SUM, AVG, MIN and MAX.
SELECT COUNT(*) AS Employee_Count,
       SUM(salary) AS Total_Salary,
       ROUND(AVG(salary), 2) AS Average_Salary,
       MIN(salary) AS Minimum_Salary,
       MAX(salary) AS Maximum_Salary
FROM Employees;

-- TASK 3: GROUP BY & HAVING
-- Show departments whose average salary is above 60,000.
SELECT d.department_name AS Department,
       COUNT(e.employee_id) AS Employee_Count,
       ROUND(AVG(e.salary), 2) AS Average_Salary
FROM Employees e
JOIN Departments d
  ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
HAVING AVG(e.salary) > 60000
ORDER BY Average_Salary DESC;

-- TASK 4: SQL JOINS
-- 4A. INNER JOIN: only departments with matching employees.
SELECT d.department_name AS Department,
       e.employee_name AS Employee,
       e.salary AS Salary
FROM Employees e
INNER JOIN Departments d
  ON e.department_id = d.department_id
ORDER BY d.department_id, e.employee_id;

-- 4B. LEFT JOIN: keep every department and show matching employees when present.
SELECT d.department_name AS Department,
       e.employee_name AS Employee,
       e.salary AS Salary
FROM Departments d
LEFT JOIN Employees e
  ON d.department_id = e.department_id
ORDER BY d.department_id, e.employee_id;

-- 4C. RIGHT JOIN: keep every department from the right-hand table.
SELECT d.department_name AS Department,
       e.employee_name AS Employee,
       e.salary AS Salary
FROM Employees e
RIGHT JOIN Departments d
  ON e.department_id = d.department_id
ORDER BY d.department_id, e.employee_id;

-- TASK 5: SQL SUBQUERIES
-- 5A. Employees earning more than the average employee salary.
SELECT employee_name AS Employee,
       salary AS Salary
FROM Employees
WHERE salary > (SELECT AVG(salary) FROM Employees)
ORDER BY salary DESC;

-- 5B. Products priced above the average product price.
SELECT product_name AS Product,
       unit_price AS Unit_Price
FROM Products
WHERE unit_price > (SELECT AVG(unit_price) FROM Products)
ORDER BY unit_price DESC;