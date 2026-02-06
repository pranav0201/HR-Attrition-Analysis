-- Query 11 — Attrition by Age Band
-- Business question: Are early-career employees leaving more?

SELECT
  CASE
    WHEN Age < 25 THEN 'Under 25'
    WHEN Age BETWEEN 25 AND 34 THEN '25-34'
    WHEN Age BETWEEN 35 AND 44 THEN '35-44'
    WHEN Age BETWEEN 45 AND 54 THEN '45-54'
    ELSE '55+'
  END AS age_band,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS employees_left,
  ROUND(100 * AVG(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END), 2) AS attrition_rate_pct
FROM employee_attrition_clean
GROUP BY age_band
ORDER BY attrition_rate_pct DESC, total_employees DESC;


-- Query 12 — Attrition by Tenure Band (YearsAtCompany)

--Business question: Is attrition highest in the first few years?

SELECT
  CASE
    WHEN YearsAtCompany < 2 THEN '0-1 yrs'
    WHEN YearsAtCompany BETWEEN 2 AND 4 THEN '2-4 yrs'
    WHEN YearsAtCompany BETWEEN 5 AND 9 THEN '5-9 yrs'
    WHEN YearsAtCompany BETWEEN 10 AND 14 THEN '10-14 yrs'
    ELSE '15+ yrs'
  END AS tenure_band,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS employees_left,
  ROUND(100 * AVG(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END), 2) AS attrition_rate_pct
FROM employee_attrition_clean
GROUP BY tenure_band
ORDER BY attrition_rate_pct DESC;


-- Query 13 — Attrition vs Promotion Stagnation (YearsSinceLastPromotion)

--Business question: Are employees leaving because they aren’t getting promoted?

SELECT
  CASE
    WHEN YearsSinceLastPromotion = 0 THEN 'Promoted this year'
    WHEN YearsSinceLastPromotion BETWEEN 1 AND 2 THEN '1-2 yrs since promo'
    WHEN YearsSinceLastPromotion BETWEEN 3 AND 5 THEN '3-5 yrs since promo'
    ELSE '6+ yrs since promo'
  END AS promo_stagnation_band,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS employees_left,
  ROUND(100 * AVG(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END), 2) AS attrition_rate_pct
FROM employee_attrition_clean
GROUP BY promo_stagnation_band
ORDER BY attrition_rate_pct DESC;


-- Query 14 — Attrition by Job Satisfaction (1–4)

--Business question: Does low job satisfaction strongly correlate with attrition?

SELECT
  JobSatisfaction,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS employees_left,
  ROUND(100 * AVG(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END), 2) AS attrition_rate_pct
FROM employee_attrition_clean
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;


-- Query 15 — Attrition by Environment Satisfaction (1–4)

--Business question: Is workplace environment a major retention driver?

SELECT
  EnvironmentSatisfaction,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS employees_left,
  ROUND(100 * AVG(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END), 2) AS attrition_rate_pct
FROM employee_attrition_clean
GROUP BY EnvironmentSatisfaction
ORDER BY EnvironmentSatisfaction;


-- Query 16 — Attrition by WorkLifeBalance (1–4)

--Business question: Does work-life imbalance increase attrition?

SELECT
  WorkLifeBalance,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS employees_left,
  ROUND(100 * AVG(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END), 2) AS attrition_rate_pct
FROM employee_attrition_clean
GROUP BY WorkLifeBalance
ORDER BY WorkLifeBalance;


-- Query 17 — Attrition by Commute Distance Band

--Business question: Are longer commutes associated with higher attrition?

SELECT
  CASE
    WHEN DistanceFromHome <= 5 THEN '0-5'
    WHEN DistanceFromHome BETWEEN 6 AND 10 THEN '6-10'
    WHEN DistanceFromHome BETWEEN 11 AND 20 THEN '11-20'
    ELSE '21+'
  END AS commute_band,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS employees_left,
  ROUND(100 * AVG(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END), 2) AS attrition_rate_pct
FROM employee_attrition_clean
GROUP BY commute_band
ORDER BY attrition_rate_pct DESC;


-- Query 18 — Training Impact (Avg Trainings): Stayed vs Left

--Business question: Are leavers receiving less training?

SELECT
  Attrition,
  ROUND(AVG(TrainingTimesLastYear), 2) AS avg_trainings_last_year,
  COUNT(*) AS employees
FROM employee_attrition_clean
GROUP BY Attrition;


--Query 19 — Attrition by JobLevel

--Business question: Is attrition concentrated at junior levels?

SELECT
  JobLevel,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS employees_left,
  ROUND(100 * AVG(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END), 2) AS attrition_rate_pct
FROM employee_attrition_clean
GROUP BY JobLevel
ORDER BY JobLevel;


-- Query 20 — Attrition by StockOptionLevel

--Business question: Do stock options reduce attrition?

SELECT
  StockOptionLevel,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS employees_left,
  ROUND(100 * AVG(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END), 2) AS attrition_rate_pct
FROM employee_attrition_clean
GROUP BY StockOptionLevel
ORDER BY StockOptionLevel;


-- Query 21 — Combined Driver: Overtime × WorkLifeBalance

--Business question: Is overtime especially risky when work-life balance is already poor?

SELECT
  OverTime,
  WorkLifeBalance,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS employees_left,
  ROUND(100 * AVG(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END), 2) AS attrition_rate_pct
FROM employee_attrition_clean
GROUP BY OverTime, WorkLifeBalance
ORDER BY attrition_rate_pct DESC, total_employees DESC;


--Query 22 — Targeting Insight: Top Job Roles by Attrition Rate (min 30 employees)

--Business question: Which roles should HR prioritize (statistically meaningful)?

SELECT
  JobRole,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS employees_left,
  ROUND(100 * AVG(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END), 2) AS attrition_rate_pct
FROM employee_attrition_clean
GROUP BY JobRole
HAVING COUNT(*) >= 30
ORDER BY attrition_rate_pct DESC, employees_left DESC;
