use school_sport_clubs;
(select s.name as Sport, sg.location as Place
from sports as s left join sportGroups as sg
on s.id = sg.sport_id)
union
(select s.name as Sport, sg.location as Place
from sports as s right join sportGroups as sg
on s.id = sg.sport_id);

select firstStud.name as Student1, secondStud.name as Student2, sports.name as Sport
from students as firstStud join students as secondStud
on firstStud.id > secondStud.id
join sports on (firstStud.id in 
(select student_id from student_sport where sportGroup_id in 
(select id from sportGroups where sportGroups.sport_id = sports.id))
and (secondStud.id in 
(select student_id from student_sport where sportGroup_id in
(select id from sportGroups where sportGroups.sport_id = sports.id))))

where firstStud.id in
(select student_id from student_sport where sportGroup_id in 
(select sportGroup_id from student_sport where student_id = secondStud.id))
order by sport;