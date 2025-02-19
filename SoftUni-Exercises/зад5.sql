delimiter $$
create procedure raise_salary_by_id(id int)
begin
	start transaction;
    if((select count(employee_id) from employees where employee_id like id)<> 1) then
    rollback;
    else
		update employees as e
        set salary = salary * 1.05
        where e.employee_id = id;
	end if;
end $$

delimiter ;

call raise_salary_by_id(178);