drop database if exists Football;
create database football;
use football;

create table teams(
teamId int auto_increment primary key,
teamName varchar(100) not null,
town varchar(100) not null,
country varchar(50) not null,
yearOfFoundation year not null
);

create table players(
playerId int auto_increment primary key,
firstName varchar(100) not null,
lastName varchar(100) not null,
position varchar(50) not null,
egn varchar(10) not null unique,
country varchar(100),
teamId int not null,
constraint foreign key (teamId) references teams(teamId)
);

create table games(
gameId int auto_increment primary key,
gameDate datetime not null,
result varchar(20) not null,
homeId int not null,
awayId int not null,
constraint foreign key (homeId) references teams(teamId),
constraint foreign key (awayId) references teams(teamId)
);

create table gameEvents(
eventsId int auto_increment primary key,
eventType varchar(255) not null,
eventMinute varchar(125) not null,
teamId int,
playerId int,
gameId int,
constraint foreign key (teamId) references teams(teamId),
constraint foreign key (playerId) references players(playerId),
constraint foreign key (gameId) references games(gameId)
);

create table coaches(
coachId int auto_increment primary key,
firstName varchar(255) not null,
lastName varchar(255) not null,
country varchar(255) not null,
wage decimal(16, 2),
teamId int,
constraint foreign key (teamId) references teams(teamId)
);

select games.gameDate, t1.teamName as homeTeam, t2.teamName as awayTeam, players.firstName, gameEvents.eventType
from games
join teams t1 on games.homeId = t1.teamId
join teams t2 on games.awayId = t2.teamId
join gameEvents on games.gameId = gameEvents.gameId
join players on gameEvents.playerId = players.playerId
order by games.gameDate;

select teams.teamName, coaches.firstName, coaches.lastName, coaches.wage
from teams
join coaches on teams.teamId = coaches.teamId
order by coaches.wage;

select players.country, count(gameEvents.eventsId) as goalScored
from players
join gameEvents on players.playerId = gameEvents.playerId
group by players.country
order by goalScored;

create view team_player_count as
select teams.teamName, teams.country, count(players.playerId) as playerCount
from teams
join players on teams.teamId = players.teamId
group by teams.teamName;