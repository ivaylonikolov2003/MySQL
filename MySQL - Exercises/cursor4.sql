delimiter $
create procedure UpdateCoachSalaryBasedOnPerformance()
begin
	declare done int default false;
    declare c_id int;
    declare avg_attendance decimal(10, 2);
    
    declare coach_cursor cursor for select id from coaches;
    declare continue handler for not found set done = true;
    
    open coach_cursor;
    
    update_loop: loop
		fetch coach_cursor into c_id;
        if done then
			leave update_loop;
		end if;
        
		select avg(a.attendance) into avg_attendance
        from (select count(*) as attendance from coach_work join sportgroups on coach_work.group_id = sportgroups.id
        where sportgroups.coach_id = c_id group by coach_work.group_id) as a;
        
        if avg_attendance > 20 then
			update coaches set month_salary = month_salary + 100 where id = c_id;
		end if;
	end loop;
    close coach_cursor;
end $
delimiter ;

call UpdateCoachSalaryBasedOnPerformance();