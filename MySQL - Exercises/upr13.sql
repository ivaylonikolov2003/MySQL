delimiter $$
create procedure sportInfoCoaches(in sportName varchar(255))
begin
select coaches.name, sportgroups.location, sportgroups.dayOfWeek, sportgroups.hourOfTraining
from sports
join sportgroups on sports.id = sportgroups.sport_id
join coaches on sportgroups.coach_id = coaches.id
where sports.name = sportName;
end $$
delimiter ;

call sportInfoCoaches('Football');
call GetCoachesBySport('Football');