delimiter $$
create procedure usp_get_employees_salary_above(number double(19, 4))
begin
	select first_name, last_name
    from employees
    where salary >= number
    order by first_name, last_name, employee_id;
end $$
delimiter ;

CALL usp_get_employees_salary_above(48100);