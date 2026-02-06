-- Query 1 — Total employees 
-- Business question: How large is the workforce in the dataset?

SELECT COUNT(*) AS total_employees
FROM employee_attrition_clean;

-- Query 2 — Total attrition (employees who left)
-- Business question: How many employees left?

SELECT COUNT(*) AS employees_left
FROM employee_attrition_clean
WHERE Attrition = 'Yes';

-- Query 3 — Overall attrition rate (%)
-- Business question: What is the company-wide attrition rate?

SELECT 
  ROUND(100 * AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END), 2) AS attrition_rate_pct
FROM employee_attrition_clean;

-- Query 4 — Attrition count & rate by Department
-- Business question: Which departments have the highest attrition?

SELECT
  Department,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
  ROUND(100 * AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END), 2) AS attrition_rate_pct
FROM employee_attrition_clean
GROUP BY Department
ORDER BY attrition_rate_pct DESC, employees_left DESC;


-- Query 5 — Attrition count & rate by JobRole
-- Business question: Which job roles are most impacted?

SELECT
  JobRole,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
  ROUND(100 * AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END), 2) AS attrition_rate_pct
FROM employee_attrition_clean
GROUP BY JobRole
ORDER BY attrition_rate_pct DESC, employees_left DESC;


-- Query 6 — Attrition by Gender
-- Business question: Is attrition skewed by gender?

SELECT
  Gender,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
  ROUND(100 * AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END), 2) AS attrition_rate_pct
FROM employee_attrition_clean
GROUP BY Gender
ORDER BY attrition_rate_pct DESC;


-- Query 7 — Attrition by MaritalStatus
-- Business question: Does marital status show different attrition patterns?

SELECT
  MaritalStatus,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
  ROUND(100 * AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END), 2) AS attrition_rate_pct
FROM employee_attrition_clean
GROUP BY MaritalStatus
ORDER BY attrition_rate_pct DESC, employees_left DESC;


-- Query 8 — Attrition by BusinessTravel
-- Business question: Does business travel increase attrition?

SELECT
  BusinessTravel,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
  ROUND(100 * AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END), 2) AS attrition_rate_pct
FROM employee_attrition_clean
GROUP BY BusinessTravel
ORDER BY attrition_rate_pct DESC;


-- Query 9 — Attrition by OverTime
-- Business question: Is overtime a major attrition driver?

SELECT
  OverTime,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
  ROUND(100 * AVG(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END), 2) AS attrition_rate_pct
FROM employee_attrition_clean
GROUP BY OverTime
ORDER BY attrition_rate_pct DESC;


-- Query 10 — Avg MonthlyIncome: Stayed vs Left
-- Business question: Do leavers earn less than stayers?

SELECT
  Attrition,
  ROUND(AVG(MonthlyIncome), 0) AS avg_monthly_income,
  MIN(MonthlyIncome) AS min_monthly_income,
  MAX(MonthlyIncome) AS max_monthly_income
FROM employee_attrition_clean
GROUP BY Attrition;
