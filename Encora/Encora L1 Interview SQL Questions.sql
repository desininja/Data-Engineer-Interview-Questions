/* table1

team_name id

ind   1
pak   2
aus   3

Make pair of each team with each other without duplicate pair.
ind pak
pak ind
*/

select t1.team_name, t2.team_name
from table1 as t1
cross join table2 as t2
where t1.id < t2.id

---------------------------------------------------------------------------
/* 
Below are the two tables find the running sum based on id of product and year.
table2

id  year  price
1   2010  34
1   2011  45
1
2
2
table3

id name


-- Output Example:
id  year  price  running_sum
1   2010  34       34
1   2011  45       79
1   2012  10       55
2
2

*/

select id, year, price,
      sum(price) over(partition by id order by year
       rows between preceding 1 and current row ) as running_sum
from table2


----------------------------------------------

-- Find the price hike between two consecutive years for a product.
select
       concat(y1,'-',y2) as period,
       max(p1 - p2) as price_hike

from (
select  id,
        year as y1,
        lag(year) over(partition by id order by year) as y2,
        price as p1,
        lag(price) over(partition by id order by year) p2
from table2
) as temp

-- Do it using CTE
with cte_price as (
select  id,
        year as y1,
        lag(year) over(partition by id order by year) as y2,
        price as p1,
        lag(price) over(partition by id order by year) p2
from table2
),

cte_hike as (id,
concat(y1,'-',y2) as period,
p1 - p2 as price_hike,
dense_rank() over(partition by id order by p1 - p2 DESC ) as d_rank

from cte_price
)

select id, period, price_hike
where d_rank = 1
from cte_hike

