use school_sport_clubs;

select students.name, students.class, students.phone
from students
join student_sport on students.id = student_sport.student_id
join sportGroups on student_sport.sportGroup_id = sportGroups.id
join sports on sportGroups.sport_id = sports.id
where sports.name = 'Football';

select coaches.name 
from coaches
join sportGroups on coaches.id = sportGroups.coach_id
join sports on sportGroups.sport_id = sports.id
where sports.name = 'Volleyball';

select coaches.name, sports.name
from students
join student_sport on students.id = student_sport.student_id
join sportGroups on student_sport.sportGroup_id = sportGroups.id
join sports on sportGroups.sport_id = sports.id
join coaches on sportGroups.coach_id = coaches.id
where students.name = 'Iliyan Ivanov';

select students.name, students.class, sportGroups.location, coaches.name
from students
join student_sport on students.id = student_sport.student_id
join sportGroups on student_sport.sportGroup_id = sportGroups.id
join coaches on sportGroups.coach_id = coaches.id
where sportGroups.hourOfTraining = '08:00:00';
