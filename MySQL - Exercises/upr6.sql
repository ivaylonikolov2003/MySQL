delimiter $$
create procedure SportInfo(IN sportId int)
begin
select sports.name, students.name, coaches.name
from sports
join sportgroups on sports.id = sportgroups.sport_id
join coaches on sportgroups.coach_id = coaches.id
join student_sport on sportgroups.id = student_sport.sportGroup_id
join students on student_sport.student_id = students.id
where sports.id = sportId;
end $$
delimiter ;

CALL SportInfo(2);