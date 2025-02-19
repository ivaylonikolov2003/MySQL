use school_sport_clubs;

select s1.name as student1, s2.name as student2, sportGroups.location, sportGroups.dayOfWeek, sportGroups.hourOfTraining
from students as s1
join student_sport as ss1 on s1.id = ss1.student_id
join sportGroups on ss1.sportGroup_id = sportGroups.id
join students as s2 on s1.id < s2.id
join student_sport as ss2 on s2.id = ss2.student_id and ss1.sportGroup_id = ss2.sportGroup_id
join sports on sportGroups.sport_id = sports.id
where sports.name = 'Football';

create view trainingStudents
as select students.name, students.class, sportGroups.location, coaches.name as coach_name
from studentstrainingstudents
join student_sport on students.id = student_sport.student_id
join sportGroups on student_sport.sportGroup_id = sportGroups.id
join coaches on sportGroups.coach_id = coaches.id
where sportGroups.hourOfTraining = '08:00:00';

select sports.name, count(student_sport.student_id) as numStudents
from sports
join sportGroups on sports.id = sportGroups.sport_id
join student_sport on sportGroups.id = student_sport.sportGroup_id
group by sports.name;