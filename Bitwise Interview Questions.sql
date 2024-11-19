table employe
name, dept, salary

-- 2nd highest sal for each dept

select name, dept, salary
from (
select name, dept, salary,
    dense_rank() over(partition by dept order by salary DESC) as d_rank
from employee
) as temp
where d_rank = 2;
-- random ranking in row number

table transaction
trans_id, trans_date, trans_amt

-- new column cummulative amount each month
--
select concat(month(trans_date)) as trans_month,
      sum(trans_amt) as total_trans_amt
from transaction
group by  1
-------------------


select month(trans_date) as trans_month,
      sum(trans_amt) over(between unbounded preceding and current row order by Month(trans_date))
        as cummulative_sum
from transaction
group by  1

---------------------




perspective: spark set up in local, maintenance of spark cluster.
