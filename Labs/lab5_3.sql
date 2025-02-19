USE school_sport_clubs;

SELECT s1.name AS student1, s2.name AS student2, sg.location, sg.dayOfWeek, sg.hourOfTraining
FROM students AS s1
JOIN student_sport AS ss1 ON s1.id = ss1.student_id
JOIN sportGroups AS sg ON ss1.sportGroup_id = sg.id
JOIN students AS s2 ON s1.id < s2.id
JOIN student_sport AS ss2 ON s2.id = ss2.student_id AND ss1.sportGroup_id = ss2.sportGroup_id
JOIN sports AS sp ON sg.sport_id = sp.id
WHERE sp.name = 'Football';

CREATE VIEW training_students
AS SELECT s.name AS student_name,
s.class,
sg.location AS training_location,
c.name AS coach_name
FROM students s
JOIN student_sport ss ON s.id = ss.student_id
JOIN sportGroups sg ON ss.sportGroup_id = sg.id
JOIN coaches c ON sg.coach_id = c.id
WHERE sg.hourOfTraining = '08:00:00';
SELECT * FROM training_students;

SELECT s.name AS sport_name,
COUNT(ss.student_id) AS num_students
FROM sports s
LEFT JOIN sportGroups sg ON s.id = sg.sport_id
LEFT JOIN student_sport ss ON sg.id = ss.sportGroup_id
GROUP BY s.name;
