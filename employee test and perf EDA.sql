SELECT * FROM employee_test
LIMIT 10;
SELECT * FROM employee_perf
LIMIT 10;

-- How many employee do we have in the organization and what is the maximum length of service
SELECT COUNT(employee_id) AS totalemployee, MAX(length_of_service)Max_Length_of_Service
FROM employee_test;

-- How many employees are there in each department?
SELECT department, COUNT (*) AS Employee_count
FROM employee_test
GROUP BY department
ORDER BY Employee_count DESC;

-- What is the proportion of male to female employees?
SELECT gender, COUNT (*) FROM employee_test
GROUP BY gender;

-- Group employee age into 5 categories (20-29, 30-39, 40-49, 50-59, >60). What age group has the highest and lowest employee?
SELECT CASE 
WHEN age BETWEEN 20 AND 29 THEN '20-29'
WHEN age BETWEEN 30 AND 39 THEN '30-39'
WHEN age BETWEEN 40 AND 49 THEN '40-49'
WHEN age BETWEEN 50 AND 59 THEN '50-59'
ELSE '>60'
END AS AgeGroup,
COUNT (employee_id) AS EmployeeCount
FROM employee_test
GROUP BY AgeGroup
ORDER BY EmployeeCount DESC;

-- Who works in the finance department?
SELECT * FROM employee_test
WHERE department LIKE '%Finance%'
LIMIT 10;

-- Who has the average training score among all employees?
SELECT employee_id, MAX (avg_training_score) AS highest_score
FROM employee_test
GROUP BY employee_id
ORDER BY avg_training_score DESC
LIMIT 2;

-- Which regions has the highest number of departures (employees who have left) and what are the corresponding department?
SELECT et.region, et.department, COUNT(et.employee_id) AS departures
FROM employee_perf AS ep
RIGHT JOIN employee_test AS et
ON ep.employee_id = et.employee_id
WHERE ep.attrition = 'Yes'
GROUP BY et.region, et.department
ORDER BY departures DESC
LIMIT 10;

-- which department has the most employees, and which department has the fewest employees?
-- Sub query to count and employees per department and find the department with the most employee
WITH department_counts AS (
SELECT department, COUNT (*) AS employee_count
FROM employee_test GROUP BY department)
SELECT department, employee_count
FROM department_counts
ORDER BY employee_count DESC
LIMIT 1;

--Query to find the department with the fewest employees
WITH department_counts AS (
SELECT department, COUNT (*) AS employee_count
FROM employee_test GROUP BY department)
SELECT department, employee_count
FROM department_counts
ORDER BY employee_count ASC
LIMIT 1;

-- Who are the top 5 highest-earning employees in the technology department
SELECT et.employee_id, et.department, ep.monthlyincome AS highestearner
FROM employee_perf AS ep
RIGHT JOIN employee_test AS et
ON et.employee_id = ep.employee_id
WHERE department LIKE '%Technology%'
ORDER BY highestearner DESC
LIMIT 5;

-- Who are the employees with awards in departments with more than 10 employees, and what are their department names?
WITH dept_counts AS (
     SELECT department, COUNT(employee_id) AS
employee_count
     FROM employee_test
     GROUP BY department
     HAVING COUNT(employee_id)>10
)
SELECT et.employee_id, et.awards_won, et.department
FROM employee_test AS et
JOIN dept_counts AS dc
ON eT.department = dc.department
ORDER BY et.awards_won DESC
LIMIT 5;

















































