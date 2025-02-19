drop database if exists service;
create database service;
use service;

create table service(
id int auto_increment primary key,
serName varchar(125) not null,
price decimal(10, 2) not null,
completionTime int not null
);

create table customers(
id int auto_increment primary key,
custName varchar(225) not null,
phoneNumber varchar(20) not null,
address varchar(225) not null
);

create table employees(
id int auto_increment primary key,
empName varchar(225) not null,
position varchar(225) not null
);

create table cars(
id int auto_increment primary key,
licensePlateNumber varchar(10) not null,
make varchar(225) not null,
model varchar(225) not null,
yearOfManufacture int not null,
customerId int not null,
constraint foreign key (customerId) references customers(id)
);

create table repairs(
id int auto_increment primary key,
dateOfRepair date not null,
PerformedServices VARCHAR(255) NOT NULL,
Price DECIMAL(10,2) NOT NULL,
Paid BOOLEAN NOT NULL,
carId int not null,
customerId int not null,
employeeId int not null,
constraint foreign key (carId) references cars(id),
constraint foreign key (customerId) references customers(id),
constraint foreign key (employeeId) references employees(id)
);