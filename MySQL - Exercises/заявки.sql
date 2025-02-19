update coaches
set name = 'Alex Petkov',
	egn = '0346071929'
where id = 3;

delete from coaches
where id = 3;
select * from coaches;

insert into coaches
values(3, 'Alex Petkov', '0346061929');

create table products(
	product_id int,
    product_name varchar(25) unique,
    price decimal(4, 2)
);
insert into products
values(6, 'cookie', 0);

alter table products 
modify price decimal(4, 2) not null;

create table employees(
	employee_id int,
    first_name varchar(255) unique,
    last_name varchar(255),
    hourly_pay decimal(4, 2),
    hire_date date
);
insert into employees
values(2, 'Squidward', 'Tentacles', 15.00, '2023-01-03'),
(3, 'Spongebob', 'Squarepants', 12.50, '2023-01-04'),
(4, 'Patrick', 'Star', 12.50, '2023-01-05'),
(5, 'Sandy', 'Cheeks', 17.25, '2023-01-06');
select * from employees;

alter table employees
add constraint chk_hourly_pay check (hourly_pay >= 10.00);

alter table employees
drop check chk_hourly_pay;

select * from products;
insert into products
values(6, 'napkin', 0.00),
(7, 'fork', 0.00),
(8, 'spoon', 0.00);

alter table products
alter price set default 0;

insert into products (product_id, product_name)
values (5, 'straw'),
(6, 'napkin'),
(7, 'fork'),
(8, 'spoon');


alter table transactions
add constraint
primary key(transaction_id);

insert into transactions(amount)
values (4.99);

select * from transactions;

create table customers(
customer_id int primary key auto_increment,
first_name varchar(50),
last_name varchar(50)
);



insert into customers (first_name, last_name)
values ('Fred', 'Fish'),
('Larry', 'Lobster'),
('Bubble', 'Bass');

create table transactions(
transaction_id int primary key auto_increment,
amount decimal(5, 2),
customer_id int,
foreign key(customer_id) references customers(customer_id)
);
alter table transactions
auto_increment = 1000;

insert into transactions(amount, customer_id)
values (1.00, null);
select * from transactions;

insert into customers (first_name, last_name)
values ('Poppy', 'Puff');
select transaction_id, amount, first_name, last_name from transactions inner join customers
on transactions.customer_id = customers.customer_id;

select * from transactions left join customers
on transactions.customer_id = customers.customer_id;

select * from transactions right join customers
on transactions.customer_id = customers.customer_id;