delimiter $
create procedure calculateTotalMonthlyPayments()
begin
	declare done int default false;
    declare coach_id int;
    declare total_salary decimal(10, 2);
    declare monthly_salary decimal(10, 2);
    declare hourly_rate decimal(10, 2);
    declare total_hours int;
    declare total_hourly_payment decimal(10, 2);
    
    declare coach_cursor cursor for select id, month_salary, hour_salary from coaches;
    declare continue handler for not found set done = true;
    
    open coach_cursor;
    
    read_loop: loop
		fetch coach_cursor into coach_id, monthly_salary, hourly_rate;
        
        if done then
			leave read_loop;
		end if;
        
        select ifnull(sum(number_of_hours), 0) into total_hours
        from coach_work
        where coach_id = coach_id;
        
        set total_hourly_payment = total_hours * hourly_rate;
        set total_salary = monthly_salary + total_hourly_payment;
        select coach_id as CoachId, total_salary as TotalMonthlyPayment;
	end loop;
    close coach_cursor;

end $
delimiter ;

CALL CalculateTotalMonthlyPayments();