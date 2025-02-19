USE school_sport_clubs;

SELECT students.name, students.class, students.phone
FROM student_sport
INNER JOIN sportGroups ON student_sport.sportGroup_id = sportGroups.id
INNER JOIN sports ON sportGroups.sport_id = sports.id
INNER JOIN students ON student_sport.student_id = students.id
WHERE sports.name = 'Football';

SELECT coaches.name
FROM sportGroups
INNER JOIN sports ON sportGroups.sport_id = sports.id
INNER JOIN coaches ON sportGroups.coach_id = coaches.id
WHERE sports.name = 'Volleyball';

SELECT coaches.name, sports.name
FROM student_sport
INNER JOIN sportGroups ON student_sport.sportGroup_id = sportGroups.id
INNER JOIN sports ON sportGroups.sport_id = sports.id
INNER JOIN coaches ON sportGroups.coach_id = coaches.id
INNER JOIN students ON student_sport.student_id = students.id
WHERE students.name = 'Iliyan Ivanov';

SELECT students.name, students.class, sportGroups.location, coaches.name
FROM student_sport
INNER JOIN sportGroups ON student_sport.sportGroup_id = sportGroups.id
INNER JOIN coaches ON sportGroups.coach_id = coaches.id
INNER JOIN students ON student_sport.student_id = students.id
WHERE sportGroups.hourOfTraining = '08:00:00';

