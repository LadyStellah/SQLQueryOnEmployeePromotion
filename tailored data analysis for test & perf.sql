SELECT * FROM employee_test;
SELECT * FROM employee_perf;

-- What is the average training score of employees in each department?
SELECT department, 
ROUND(AVG(avg_training_score),0) AS AvgTrainingScore
FROM employee_test
GROUP BY department;

-- What is the average previous year rating by each department?
SELECT department, 
ROUND(AVG(previous_year_rating),0) AS AvgPrevYearRating
FROM employee_test 
GROUP BY department;

-- What is the average training score of employees by education type?
SELECT education,
ROUND(AVG(avg_training_score),0) AS AvgTrainingScoreEduType
FROM employee_test
GROUP BY education;

-- Group average training score into grades (A,B,C,D,E,F) and what grade has the highest and lowest number of employees?
SELECT 
      CASE
	  WHEN avg_training_score >=90 THEN 'A'
	  WHEN avg_training_score >=80 THEN 'B'
	  WHEN avg_training_score >=70 THEN 'C'
	  WHEN avg_training_score >=60 THEN 'D'
	  WHEN avg_training_score >=50 THEN 'E'
ELSE 'F'
END AS TrainingGrade,
COUNT (employee_id) AS EmployeeCount
FROM employee_test
GROUP BY TrainingGrade
ORDER BY EmployeeCount DESC;

-- Which three department have the highest average job satisfaction among employees with a bachelor's degree?
SELECT et.department, et.education, ROUND(AVG(ep.jobsatisfaction),0) AS AvgJobSatisfaction
FROM employee_perf AS ep
INNER JOIN employee_test AS et
ON ep.employee_id = et.employee_id
WHERE et.education = 'Bachelor''s'
GROUP BY et.department, et.education
ORDER BY AvgJobSatisfaction DESC
LIMIT 3;

-- What is the average previous year rating by recruitment channel?
SELECT recruitment_channel,
ROUND(AVG(previous_year_rating),0) AS AvgRatingChannel
FROM employee_test
GROUP BY recruitment_channel;

-- What is the split of gender by previous year rating?
SELECT gender, previous_year_rating,
COUNT(*) AS count
FROM employee_test
GROUP BY gender, previous_year_rating
ORDER BY gender, previous_year_rating
LIMIT 10;

-- Based on the age group created, what is average previous year rating and average training score?
SELECT AgeGroup, ROUND(AVG(previous_year_rating),0) AS AvgPrevYearRating,
ROUND(AVG(avg_training_score),0) AS AvgTrainingScore
FROM(
    SELECT
    CASE
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
    ELSE'>60'
    END AS AgeGroup,
    previous_year_rating, avg_training_score
FROM employee_test
) AS AgeGroupedData
GROUP BY AgeGroup;

-- What is the average age of male and female employees, and how many employees are there for each gender?
SELECT gender,ROUND(AVG(age)) AS AvgAge, COUNT (employee_id) AS EmployeeCount
FROM employee_test
GROUP BY gender, age
LIMIT 10;

-- Who are the top 5 highest-earning employee with a Joblevel of 3 or higher?
SELECT employee_id, monthlyincome, joblevel
FROM employee_perf
WHERE joblevel >=3
ORDER BY monthlyincome DESC
LIMIT 5;
