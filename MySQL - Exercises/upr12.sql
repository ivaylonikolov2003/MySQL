delimiter $$
create procedure StudInfo(in coachName varchar(255))
begin
select students.name, sportgroups.id, sports.name
from coaches
join sportgroups on coaches.id = sportgroups.coach_id
join student_sport on sportgroups.id = student_sport.sportGroup_id
join students on student_sport.student_id = students.id
join sports on sportgroups.sport_id = sports.id
where coaches.name = coachName;
end $$
delimiter ;


call StudInfo('Ivan Todorov Petkov');