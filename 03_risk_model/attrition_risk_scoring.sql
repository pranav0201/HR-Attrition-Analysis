--Attrition Risk 

DROP VIEW IF EXISTS employee_attrition_risk;

CREATE VIEW employee_attrition_risk AS
SELECT
  e.*,

  -- Risk flags
  CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END AS risk_overtime,
  CASE WHEN WorkLifeBalance <= 2 THEN 1 ELSE 0 END AS risk_worklife,
  CASE WHEN JobSatisfaction <= 2 THEN 1 ELSE 0 END AS risk_jobsat,
  CASE WHEN YearsSinceLastPromotion >= 3 THEN 1 ELSE 0 END AS risk_promo_stagnation,
  CASE WHEN YearsAtCompany < 2 THEN 1 ELSE 0 END AS risk_early_tenure,
  CASE WHEN DistanceFromHome >= 15 THEN 1 ELSE 0 END AS risk_commute,

  -- Income risk: below job-role average
  CASE
    WHEN MonthlyIncome < (
      SELECT AVG(MonthlyIncome)
      FROM employee_attrition_clean r
      WHERE r.JobRole = e.JobRole
    )
    THEN 1 ELSE 0
  END AS risk_low_income,

  -- Total risk score
  (
    CASE WHEN OverTime = 'Yes' THEN 1 ELSE 0 END +
    CASE WHEN WorkLifeBalance <= 2 THEN 1 ELSE 0 END +
    CASE WHEN JobSatisfaction <= 2 THEN 1 ELSE 0 END +
    CASE WHEN YearsSinceLastPromotion >= 3 THEN 1 ELSE 0 END +
    CASE WHEN YearsAtCompany < 2 THEN 1 ELSE 0 END +
    CASE WHEN DistanceFromHome >= 15 THEN 1 ELSE 0 END +
    CASE
      WHEN MonthlyIncome < (
        SELECT AVG(MonthlyIncome)
        FROM employee_attrition_clean r
        WHERE r.JobRole = e.JobRole
      )
      THEN 1 ELSE 0
    END
  ) AS total_risk_score

FROM employee_attrition_clean e;


--Categorize Risk Levels (Low / Medium / High)

SELECT
  EmployeeNumber,
  JobRole,
  Department,
  total_risk_score,
  CASE
    WHEN total_risk_score >= 5 THEN 'High Risk'
    WHEN total_risk_score BETWEEN 3 AND 4 THEN 'Medium Risk'
    ELSE 'Low Risk'
  END AS risk_category
FROM employee_attrition_risk;


--Business question: Who should HR intervene on immediately?

SELECT
  EmployeeNumber,
  Department,
  JobRole,
  total_risk_score,
  OverTime,
  WorkLifeBalance,
  JobSatisfaction,
  YearsSinceLastPromotion,
  YearsAtCompany
FROM employee_attrition_risk
ORDER BY total_risk_score DESC
LIMIT 25;

-->^This query allows HR to prioritize proactive retention conversations

--Business question: Does the model actually align with attrition?

SELECT
  risk_category,
  COUNT(*) AS total_employees,
  SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
  ROUND(100 * AVG(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END), 2) AS attrition_rate_pct
FROM (
  SELECT *,
    CASE
      WHEN total_risk_score >= 5 THEN 'High Risk'
      WHEN total_risk_score BETWEEN 3 AND 4 THEN 'Medium Risk'
      ELSE 'Low Risk'
    END AS risk_category
  FROM employee_attrition_risk
) t
GROUP BY risk_category
ORDER BY attrition_rate_pct DESC;

-->^Higher risk scores correspond to significantly higher attrition rates, validating the logic

--Business question: What factors drive risk the most?

SELECT 'OverTime' AS risk_factor, SUM(risk_overtime) AS affected_employees FROM employee_attrition_risk
UNION ALL
SELECT 'Low WorkLifeBalance', SUM(risk_worklife) FROM employee_attrition_risk
UNION ALL
SELECT 'Low Job Satisfaction', SUM(risk_jobsat) FROM employee_attrition_risk
UNION ALL
SELECT 'Promotion Stagnation', SUM(risk_promo_stagnation) FROM employee_attrition_risk
UNION ALL
SELECT 'Early Tenure', SUM(risk_early_tenure) FROM employee_attrition_risk
UNION ALL
SELECT 'Long Commute', SUM(risk_commute) FROM employee_attrition_risk
UNION ALL
SELECT 'Low Income vs Role Avg', SUM(risk_low_income) FROM employee_attrition_risk
ORDER BY affected_employees DESC;
