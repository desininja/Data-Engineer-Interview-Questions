/* 
table: employe
columns: name, dept, salary
*/
-- Find the 2nd highest sal for each dept

select name, dept, salary
from (
select name, dept, salary,
    dense_rank() over(partition by dept order by salary DESC) as d_rank
from employee
) as temp
where d_rank = 2;

-- Why have I not used row number function instead of dense_rank?

/*
table: transaction
columns: trans_id, trans_date, trans_amt
*/
-- New column cummulative amount each month

SELECT 
    MONTH(trans_date) AS trans_month,
    SUM(trans_amt) OVER (
        ORDER BY MONTH(trans_date) 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_sum
FROM 
    transaction
GROUP BY 
    MONTH(trans_date), trans_amt;


