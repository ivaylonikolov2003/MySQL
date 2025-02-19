use school_sport_clubs;

delimiter $
drop database if exists testProc $
create procedure testProc()
begin
select c.name, sg.location
from coaches as c join sportGroups as sg
on c.id = sg.coach_id;
end $
delimiter ;
call testProc();