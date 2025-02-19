delimiter $
create procedure generateStudentAttendanceReport()
begin
	declare finished int default false;
    declare student_id int;
    declare group_id int;
    declare attedance_count int;
    
    declare student_sport_cursor cursor for select student_id, sportGroup_id from student_sport;
    declare continue handler for not found set finished = true;
    
    open student_sport_cursor;
    
    attedance_loop: loop
		fetch student_sport_cursor into student_id, group_id;
        if finished then
			leave attedance_loop;
		end if;
        
        select count(*) into attedance_count
        from coach_work
        where group_id = group_id and coach_id in(select coach_id from sportgroups where id = group_id);
        select student_id as StudentID, group_id as SportID, attedance_count as AttendanceCount;
	end loop;
    
    close student_sport_cursor;
end $
delimiter ;

call generateStudentAttendanceReport();