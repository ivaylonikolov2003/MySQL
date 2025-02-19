use school_sport_clubs;

insert into students(name, egn, address, phone, class)
value('Ivan Ivanov Ivanov', '9207186371', 'Sofia-Serdika','0888892950', '10');

select * from students order by name asc;

delete from students where egn = '9207186371';

select students.name, sports.name 
from students 
join student_sport on students.id = student_sport.student_id
join sportGroups on student_sport.sportGroup_id = sportGroups.id
join sports on sportGroups.sport_id = sports.id;

select students.name, students.class, sportGroups.id
from students 
join student_sport on students.id = student_sport.student_id
join sportGroups on student_sport.sportGroup_id = sportGroups.id
where sportGroups.dayOfWeek = 'Monday';

select coaches.name
from coaches
join sportGroups on coaches.id = sportGroups.coach_id
where sportGroups.sport_id in(select id from sports where name = 'Football');

select sportGroups.location, sportGroups.dayOfWeek, sportGroups.hourOfTraining
from sportGroups
join sports on sportGroups.id = sports.id
where sports.name = 'Volleyball';

select sports.name
from students
JOIN student_sport ON students.id = student_sport.student_id
JOIN sportGroups ON student_sport.sportGroup_id = sportGroups.id
JOIN sports ON sportGroups.sport_id = sports.id
where students.name = 'Iliyan Ivanov';

select students.name
from students
join student_sport on students.id = student_sport.student_id
join sportGroups on student_sport.sportGroup_id = sportGroups.id
join sports on sportGroups.sport_id = sports.id
join coaches on sportGroups.coach_id = coaches.id
where coaches.name = 'Ivan Todorov Petkov' and sports.name = 'Football';


