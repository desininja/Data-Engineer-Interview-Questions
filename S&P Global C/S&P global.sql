/*
student
Id name marks
1   a
2   b
3   c
*/

with rank_student as(
select name,
       dense_rank() over(order by marks DESC) stu_rank
       from student
)

select name
from rank_student
where stu_rank = 2;

/*
course
id name
1   x
2   y

student_course_mapping
stu_id course_id  marks
1        1         10
2        1         20
1       2         30
3       2         40


all the student names, total number of course they have taken.
some of the student may not have taken course return their name.
*/
select
      s.name student_name,
      count(scm.course_id) course_count

from student as s
left join student_course_mapping as scm on s.id = scm.stu_id
group by s.name

======================
top 3 courses where students have scored max marks





-- course name and total marks


select c.name,
        sum(scm.marks)
from course as c
inner join student_course_mapping scm on c.id = scm.course_id
group by c.name
