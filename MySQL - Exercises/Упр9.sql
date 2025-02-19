drop database if exists cinemas;
create database cinemas;
use cinemas;

create table cinemas(
id int auto_increment primary key,
cinemaName varchar(150) not null,
cinemaAddress varchar(255)
);

create table halls(
id int auto_increment primary key,
hallName varchar(150) not null,
hallStatus varchar(255) not null,
cinemaId int,
constraint foreign key (cinemaId) references cinemas(id)
);

create table movies(
id int auto_increment primary key,
movieName varchar(255),
releaseYear int,
country varchar(255)
);

create table projections(
id int auto_increment primary key,
projectionsTime datetime,
audienceCount int,
movieId int,
hallId int,
constraint foreign key (movieId) references movies(id),
constraint foreign key (hallId) references halls(id)
);

select cinemas.cinemaName, halls.id, projections.projectionsTime
from cinemas
join halls on cinemas.id = halls.cinemaId
join projections on halls.id = projections.hallId
join movies on projections.movieId = movies.id
where movies.movieName = 'Final Destination 7' and
halls.hallStatus = 'VIP' or 'Deluxe'
order by cinemas.cinemaName asc, halls.id asc;

select sum(audienceCount) as totalSum
from cinemas
join halls on cinemas.id = halls.cinemaId
join projections on halls.id = projections.hallId
join movies on projections.movieId = movies.id
where movies.movieName = 'Final Destination 7' and
halls.hallStatus = 'VIP' and cinemas.cinemaName = 'Arena Mladost';


