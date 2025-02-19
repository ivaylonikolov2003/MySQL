delimiter $$
create procedure usp_get_employees_by_salary_level(salary_level varchar(10))
begin
	select first_name, last_name
    from employees
    where employees.salary < 30000 and salary_level = 'low'
    or employees.salary >= 30000 and employees.salary <= 50000 and salary_level = 'average'
    or employees.salary > 50000 and salary_level = 'high'
    order by first_name desc, last_name desc;
end $$
delimiter ;