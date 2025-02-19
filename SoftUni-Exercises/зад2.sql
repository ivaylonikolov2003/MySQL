delimiter $$
create procedure usp_select_employees_by_seniority(min_years_at_work int)
begin
	select first_name, last_name, hire_date, round(datediff(now(), date(hire_date)) / 365.25,0) as 'years'
    from employees
    where round(datediff(now(), date(hire_date)) / 365.25,0) > min_years_at_work
    order by hire_date;
end $$
delimiter ;

call usp_select_employees_by_seniority(15);