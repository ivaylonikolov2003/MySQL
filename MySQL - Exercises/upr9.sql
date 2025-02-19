delimiter $$
create procedure getStudentsInfo()
begin
select students.name
from students
join student_sport on students.id = student_sport.student_id
group by students.id
having count(student_sport.sportGroup_id) > 1;
end $$
delimiter ;

call getStudentsInfo();