table: emp
empid, name, managerid,salary


-- no. of empy under manager


select m.name, count(e.empid)
from emp as e , emp as m
where e.managerid=m.empid
group by m.name

