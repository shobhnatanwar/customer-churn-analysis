SELECT * FROM customers.`telco-customer-churn`;
SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM customers.`telco-customer-churn`;

SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM customers.`telco-customer-churn`
GROUP BY Contract
ORDER BY churn_rate DESC;

SELECT 
    CASE 
        WHEN tenure < 12 THEN '0-1 Year'
        WHEN tenure < 24 THEN '1-2 Years'
        ELSE '2+ Years'
    END AS tenure_group,
    COUNT(*) AS total,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned
FROM customers.`telco-customer-churn`
GROUP BY tenure_group
ORDER BY tenure_group;

SELECT *
FROM customers.`telco-customer-churn`
WHERE Contract = 'Month-to-month'
AND tenure < 12
AND MonthlyCharges > 70
AND Churn = 'Yes';

SELECT 
    PaymentMethod,
    COUNT(*) AS total,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned,
    ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS churn_rate
FROM customers.`telco-customer-churn`
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;

SELECT 
    TechSupport,
    COUNT(*) AS total,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned
FROM customers.`telco-customer-churn`
GROUP BY TechSupport;

SELECT 
    SUM(MonthlyCharges) AS monthly_revenue_loss
FROM customers.`telco-customer-churn`
WHERE Churn = 'Yes';

SELECT customerID, MonthlyCharges, TotalCharges
FROM customers.`telco-customer-churn`
WHERE Churn = 'Yes'
ORDER BY MonthlyCharges DESC
LIMIT 10;

SELECT 
    Contract,
    InternetService,
    COUNT(*) AS total,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned
FROM customers.`telco-customer-churn`
GROUP BY Contract, InternetService
ORDER BY churned DESC;

CREATE VIEW churn_summary AS
SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned
FROM customers.`telco-customer-churn`
GROUP BY Contract;