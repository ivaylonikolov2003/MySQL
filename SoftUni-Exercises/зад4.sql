delimiter $$
create procedure usp_raise_salaries(department_name varchar(50))
begin
	update employees e
    inner join departments as d on e.department_id = d.department_id
    set salary = salary * 1.05
    where d.name = department_name;
end $$
delimiter ;
CALL usp_raise_salaries('Sales');

