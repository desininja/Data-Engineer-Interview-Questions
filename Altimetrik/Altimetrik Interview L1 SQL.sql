/*
consider the below schema of a table subscription

columns:
subscription_id,
customer_id,
subscription_start_date,
amount
subscription_end_date

Find the
active subscriptions, inactive subscriptions on monthly basis */


WITH monthly_data AS (
    SELECT 
        DATE_TRUNC('month', subscription_start_date) AS month_year,
        CASE 
            WHEN subscription_end_date IS NULL OR subscription_end_date >= CURRENT_DATE THEN 'active'
            ELSE 'inactive'
        END AS subscription_status
    FROM 
        subscription
)
SELECT 
    month_year,
    subscription_status,
    COUNT(*) AS subscription_count
FROM 
    monthly_data
GROUP BY 
    month_year, subscription_status
ORDER BY 
    month_year, subscription_status;
