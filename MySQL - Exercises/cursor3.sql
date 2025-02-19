delimiter $

create procedure auditPaymentConsistency()
begin
	declare done int default false;
    declare student_id int;
    declare group_id int;
    declare payments int;
    declare attendance int;
    
    declare audit_cursor cursor for select student_id, group_id, count(*) as payments from taxespayments group by student_id, group_id;
    declare continue handler for not found set done = true;
    
    open audit_cursor;
    audit_loop: loop
		fetch audit_cursor into student_id, group_id, payments;
        if done then
			leave audit_loop;
		end if;
		
        select count(*) into attendance from coach_work where group_id = group_id and coach_id in (select coach_id from sportgroups where id = group_id);
        
        if payments <> attendance then
			select student_id as StudentID, group_id as GroupId, payments, attendance;
		end if;
	end loop;
    
    close audit_cursor;
end $
delimiter ;

call auditPaymentConsistency();