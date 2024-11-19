emp_table
emp_id,name,dept


salary_table
PK,FK emp_id,salary

-- Query to fetch 3rd high sal in each depart


-- temp

emp_table.createTempView("emp")
salary_table.createTempView('salary_table')


spark.sql(
"
select emp_id,name, salary
from (

select e.emp_id,
e.name ,
s.salary,

dense_rank() over(partition by e.dept order by s.salary DESC ) as d_rank

from emp_table e
inner join salary_table s on s.emp_id = e.emp_id
) as temp
where d_rank =3;")
