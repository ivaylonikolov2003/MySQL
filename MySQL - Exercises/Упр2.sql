drop database if exists application;
create database application;
use application;

create table departments(
id INT auto_increment primary key,
depName VARCHAR(255) NOT NULL
);

create table person(
id int auto_increment primary key,
perName VARCHAR(255) not null,
egn VARCHAR(10) not null unique,
address varchar(255) not null,
depId int default null,
constraint foreign key (depId) references departments(id)
);

create table programmers(
person_id int auto_increment primary key,
front_back_end enum('FRONT_END','BACK_END','FULL_STACK') null,
constraint foreign key (person_id) references person(id)
);

create table qas(
person_id int auto_increment primary key,
isAutomation bit(1) default null,
constraint foreign key (person_id) references person(id)
);

create table languages(
id int auto_increment primary key,
lanName varchar(100) not null
);

create table programmer_language(
programmer_id int not null,
language_id int not null,
primary key(programmer_id, language_id),
constraint foreign key (programmer_id) references programmers(person_id),
constraint foreign key (language_id) references languages(id)
);