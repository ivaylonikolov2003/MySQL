use school_sport_clubs;

delimiter $$
create procedure coachInfo(IN coachName varchar(255))
begin
	declare coachId int;
	select id into coachId
	from coaches
	where name = coachName;
	if coachId is not null then
		select count(*) as group_count
		from sportgroups
		where coach_id = coachId;
	else 
		select 'Coach not found' as message;
	end if;
end $$
delimiter ;
CALL coachInfo('Ivan Todorov Petkov');