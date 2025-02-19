create view StudentsNames as
select students.name, count(student_sport.student_id) as trainingGroup
from students
join student_sport on students.id = student_sport.student_id
group by students.id;