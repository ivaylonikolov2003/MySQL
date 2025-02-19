create table deleted_employees(
employee_id int primary key auto_increment,
first_name varchar(20),
last_name varchar(20),
middle_name varchar(20),
job_title varchar(50),
department_id int,
salary double
);

delimiter $$
create trigger inserts_into_deleted_employees
after delete on employees
for each row
begin
	insert into deleted_employees(first_name,last_name,middle_name,job_title,department_id,salary)
    values(OLD.first_name,OLD.last_name,OLD.middle_name,OLD.job_title,OLD.department_id,OLD.salary);
end $$
delimiter ;

DELETE FROM employees WHERE employee_id IN (1);