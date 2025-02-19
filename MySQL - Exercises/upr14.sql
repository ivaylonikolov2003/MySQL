create trigger update_salary
before update on employees
for each row 
set NEW.salary = (NEW.hourly_pay * 2080);

create trigger before_hourly_pay_insert
before insert on employees
for each row
set new.salary = (new.hourly_pay * 2080);

create table expenses(
expense_id int primary key,
expense_name varchar(50),
expense_total decimal(10, 2)
);
insert into expenses
values (1, 'salaries', 0),
(2, 'supplies', 0),
(3, 'taxes', 0);

update expenses
set expense_total = (select sum(salary) from employees)
where  expense_name = 'salaries';

create trigger after_salary_delete
after delete on employees
for each row 
update expenses
set expense_total = expense_total - OLD.salary
where expense_name = 'salaries';

create trigger after_salary_insert
after insert on employees
for each row
update expenses
set expense_total = expense_total + new.salary
where expense_name = 'salaries';

insert into employees
values (6, 'Sheldon', 'Plankton', 10, null, '2023-01-07');

create trigger after_salary_update
after update on employees
for each row
update expenses
set expense_total = expense_total + (new.salary - old.salary)
where expense_name = 'salaries';

update employees
set hourly_pay = 80
where employee_id = 1;
select * from expenses;