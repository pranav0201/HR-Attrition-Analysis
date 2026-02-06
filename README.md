HR Attrition Analysis using MySQL
<<<-----------------------Project Overview----------------------->>>

Employee attrition is a critical business problem that impacts hiring costs, productivity, and team stability.
This project uses MySQL to analyze employee attrition data and identify key drivers of attrition, high-risk employee groups, and actionable insights that HR teams can use to improve retention.

The project follows a real-world analytics workflow — from raw data ingestion to KPI development, driver analysis, and proactive risk identification — focusing on explainable, business-ready insights rather than black-box models.

<<<-----------------------Business Objectives----------------------->>>

-Measure overall employee attrition and identify high-risk segments
-Understand how factors such as workload, tenure, compensation, and satisfaction influence attrition
-Proactively identify employees at high risk of leaving using a rule-based SQL model
-Translate data findings into actionable HR recommendations

<<<-----------------------Tools & Technologies----------------------->>>

-MySQL
-SQL (views, CASE statements, aggregations, subqueries)
-GitHub for version control and documentation

<<<-----------------------Dataset----------------------->>>

-IBM HR Employee Attrition Dataset
-1,470 employee records
-35 HR-related attributes including:
   -Demographics
   -Job roles and departments
   -Compensation
   -Workload
   -Satisfaction metrics
   -Career progression indicators

<<<-----------------------Project Structure----------------------->>>

   HR-Attrition-Analysis/
│
├── 01_data_setup/
│   ├── database_setup.sql
│   ├── raw_table_creation.sql
│   └── clean_view.sql
│
├── 02_analysis_queries/
│   ├── baseline_kpis.sql
│   ├── attrition_drivers.sql
│
├── 03_risk_model/
│   └── attrition_risk_scoring.sql
│
├── insights.md
└── README.md

<<<-----------------------Analytical Approach----------------------->>>

1.Data Ingestion & Validation
   -Imported raw HR data into MySQL
   -Performed row-count and key integrity checks

2.Data Preparation
   -Created a clean analytical view to remove non-informative fields
   -Preserved raw data as a source of truth

3.KPI Development
   -Built baseline attrition metrics
   -Segmented attrition by department, role, tenure, workload, and satisfaction

4.Driver Analysis
   -Identified key factors influencing employee exits
   -Compared demographic, compensation, workload, and career progression variables

5.Attrition Risk Scoring
   -Developed a rule-based SQL model to flag high-risk employees
   -Validated risk scores against historical attrition outcomes

<<<-----------------------Key Outcomes----------------------->>>

-Identified early-tenure employees and overtime workers as the highest attrition risk groups
-Found promotion stagnation and job satisfaction to be stronger drivers than salary alone
-Built a proactive attrition risk scoring framework using SQL

<<<-----------------------Business Value----------------------->>>

This project demonstrates how SQL can be used beyond reporting to support strategic HR decision-making, enabling organizations to move from reactive attrition analysis to proactive workforce planning.
