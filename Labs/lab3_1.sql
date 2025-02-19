use school_sport_clubs;

INSERT INTO students (name, egn, address, class, phone)
VALUES ('Ivan Ivanov Ivanov', '9207186371', 'София-Сердика', 10, '0888892950');

SELECT * FROM students ORDER BY name ASC;

DELETE FROM students WHERE egn = '9207186371';

SELECT students.name, sports.name
FROM students
JOIN student_sport ON students.id = student_sport.student_id
JOIN sportGroups ON student_sport.sportGroup_id = sportGroups.id
JOIN sports ON sportGroups.sport_id = sports.id;

SELECT students.name, students.class, sportGroups.id
FROM students
JOIN student_sport ON students.id = student_sport.student_id
JOIN sportGroups ON student_sport.sportGroup_id = sportGroups.id
WHERE sportGroups.dayOfWeek = 'Monday';

SELECT coaches.name
FROM coaches
JOIN sportGroups ON coaches.id = sportGroups.coach_id
WHERE sportGroups.sport_id IN (SELECT id FROM sports WHERE name = 'Football');

SELECT sportGroups.location, sportGroups.hourOfTraining, sportGroups.dayOfWeek
FROM sportGroups
JOIN sports ON sportGroups.sport_id = sports.id
WHERE sports.name = 'Volleyball';

SELECT sports.name
FROM students
JOIN student_sport ON students.id = student_sport.student_id
JOIN sportGroups ON student_sport.sportGroup_id = sportGroups.id
JOIN sports ON sportGroups.sport_id = sports.id
WHERE students.name = 'Iliyan Ivanov';

SELECT students.name
FROM students
JOIN student_sport ON students.id = student_sport.student_id
JOIN sportGroups ON student_sport.sportGroup_id = sportGroups.id
JOIN coaches ON sportGroups.coach_id = coaches.id
JOIN sports ON sportGroups.sport_id = sports.id
WHERE coaches.name = 'Ivan Todorov Petkov' AND sports.name = 'Football';