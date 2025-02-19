use school_sport_clubs;

select students.name, students.class, students.phone
from students
join student_sport on students.id = student_sport.student_id
join sportGroups on student_sport.sportGroup_id = sportgroups.id
join sports on sportGroups.sport_id = sports.id
where sports.name = 'Football';

select coaches.name
from coaches
join sportGroups on coaches.id = sportGroups.coach_id
join sports on sportgroups.sport_id = sports.id
where sports.name = 'Volleyball';

select coaches.name, sports.name, sportGroups.dayOfWeek, sportgroups.location
from students
join student_sport on students.id = student_sport.student_id
join sportgroups on student_sport.sportGroup_id = sportgroups.id
join sports on sportgroups.sport_id = sports.id
join coaches on sportgroups.coach_id = coaches.id
where students.name = 'Maria Hristova Dimova';

select students.name, taxespayments.month, sum(taxespayments.paymentAmount) as totalPayment
from taxespayments
join students on taxespayments.student_id = students.id
join sportgroups on students.id = sportgroups.coach_id
join coaches on sportgroups.coach_id = coaches.id
where coaches.egn = '7509041245'
group by students.name, taxespayments.month
having totalPayment > 700;

select count(*) as totalFootballers
from students
join student_sport on students.id = student_sport.student_id
join sportgroups on student_sport.sportGroup_id = sportgroups.id
join sports on sportgroups.sport_id = sports.id
where sports.name = 'Football';

select coaches.name, sports.name as sportName
from coaches
left join sportgroups on coaches.id = sportgroups.coach_id
left join sports on sportgroups.sport_id = sports.id;

select sports.name, sportgroups.location, count(student_sport.student_id) as studentCount
from sportgroups
join sports on sportgroups.sport_id = sports.id
join student_sport on sportgroups.id = student_sport.sportGroup_id
group by sportgroups.id
having studentCount >= 3;


