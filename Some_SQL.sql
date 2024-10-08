-- Left join with specified columns 
SELECT 
    t1.col_1
    t1.id
    t2.col_1
FROM 
    table1 t1 LEFT JOIN table2 t2 
ON 
    t1.id = t2.id;


-- Sum stats of salary by department, and rank descending 
SELECT
    department_id, 
	MIN(salary) as min_salary, 
	SUM(salary) as sum_salary, 
	ROUND(AVG(salary), 2) AS avg_salary, 
	round(STDDEV_POP(salary), 2) AS stddev_salary
FROM 
    data_sci.employees
GROUP BY department_id
ORDER BY sum_salary;

-- Top 10 highest paid employees:
SELECT 
    last_name, department_id, salary
FROM 
    data_sci.employees
WHERE
    salary > 10000
ORDER BY 
    salary DESC
LIMIT 10;

-- Employees with surname beginning with B
SELECT 
	last_name, department_id, salary
FROM 
	data_sci.employees
WHERE
	last_name LIKE 'b%';

-- Sum of salaries > 100000 by dept
SELECT 
	department_id, SUM(salary)
FROM 
	data_sci.employees
WHERE
	salary > 100000
GROUP BY 
    department_id;

-- Basic join with filter
SELECT 
    e.last_name,
    e.email,
    e.start_date,
    e.salary,
    cr.region_name, 
    cr.country_name
FROM
    data_sci.employees e
JOIN
    data_sci.company_regions cr
ON 
    e.region_id = cr.id
WHERE
    cr.country_name = 'canada'; -- case sensitive!

-- last name, email, dept name for salary > 120000
SELECT 
    e.last_name,
    e.email,
    e.salary,
    cd.department_name 
FROM
    data_sci.employees e
JOIN
    data_sci.company_departments cd
ON 
    e.department_id = cd.id
WHERE
    e.salary > 120000;

-- ####################################################
-- Aggregate functions:
VAR_POP() -- variance
STDDEV_POP() -- Population std dev
STDDEV_SAMP() -- Sample std dev
MIN()
MAX()
SUM()
AVG() --mean
ROUND(colname, 2) -- same as Python

--Correlation 
CORR(x, y) -- Correlation coefficient

-- Select all distinct pet names from two tables with the same column name in one row with UNION:
SELECT DISTINCT name FROM cats
UNION 
SELECT DISTINCT name FROM dogs;

--Write a query that selects only the names of employees who are not managers (managerId can contain nulls).
SELECT name FROM employees WHERE Id NOT IN(
  SELECT managerId FROM employees WHERE managerId NOT NULL);
  
--Write a query that selects userId and average session duration for each user who has more than one session  
SELECT userId, AVG(duration) FROM sessions
  GROUP BY userId HAVING COUNT() >1;  


--Return the 6th highest paid employee using a subquery
SELECT * from (
	SELECT * FROM employees
	ORDER BY salary DESC
	LIMIT 6
	) 
AS top6
ORDER BY salary ASC
LIMIT 1;


--SSMS specific functions------------------------------------------------------------------------------------
--Get today's date
GETDATE()

--Calculate difference in days between a date and today
DATEDIFF(day, some_date_column, GETDATE()) [difference_in_days]

--Select rows where a date is within the last 2 weeks
SELECT date_col, 
       columns_you_want  
FROM some_table
-- select everything in the last 14 days
WHERE some_table.date_col >= DATEADD(DAY, -14, CONVERT(DATE, GETDATE()))
ORDER BY some_table.date_col DESC
