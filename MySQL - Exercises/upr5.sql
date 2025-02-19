use school_sport_clubs;

delimiter $$
create procedure coachName(IN coachesName VARCHAR(255))
begin
select sports.name, sportgroups.location, sportgroups.dayOfWeek, sportgroups.hourOfTraining, students.name, students.phone
from coaches
join sportgroups on coaches.id = sportgroups.coach_id
join sports on sportgroups.sport_id = sports.id
join student_sport on sportgroups.id = student_sport.sportGroup_id
join students on student_sport.student_id = students.id
where coaches.name = coachesName;
end $$
delimiter ;

call coachName('Ivan Todorov Petkov');