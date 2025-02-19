drop database if exists employee;
create database employee;
use employee;

create table department(
id int auto_increment primary key,
depName varchar(20) not null,
depLocation varchar(15) not null
);

create table employees(
id int auto_increment primary key,
empName varchar(255) not null,
jobName varchar(255) not null,
managerId int not null,
hireDate date, 
salary decimal(10, 2),
commission decimal(7, 2),
depId int not null
);

create table salaryGrade(
id int auto_increment primary key,
minSalary int not null,
maxSalary int not null
);


insert into employees
values(1, "Ivan", "coach", 3, "2024-01-02", 25.50, 10.50, 2);
select * from employees;







