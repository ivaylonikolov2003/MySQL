use school_sport_clubs;

SELECT s.name, s.class, s.phone
FROM students s
JOIN student_sport ss ON s.id = ss.student_id
JOIN sportGroups sg ON ss.sportGroup_id = sg.id
JOIN sports sp ON sg.sport_id = sp.id
WHERE sp.name = 'Football';

SELECT c.name
FROM coaches c
JOIN sportGroups sg ON c.id = sg.coach_id
JOIN sports sp ON sg.sport_id = sp.id
WHERE sp.name = 'Volleyball';

SELECT c.name AS coach_name, sp.name AS sport_name, sg.dayOfWeek, sg.location
FROM students s
JOIN student_sport ss ON s.id = ss.student_id
JOIN sportGroups sg ON ss.sportGroup_id = sg.id
JOIN sports sp ON sg.sport_id = sp.id
JOIN coaches c ON sg.coach_id = c.id
WHERE s.name = 'Maria Hristova Dimova';

SELECT s.name, tp.month, SUM(tp.paymentAmount) AS total_payment
FROM taxesPayments tp
JOIN students s ON tp.student_id = s.id
JOIN sportgroups sg ON s.id = sg.coach_id
JOIN coaches c ON sg.coach_id = c.id
WHERE c.EGN = '7509041245'
GROUP BY s.name, tp.month
HAVING total_payment > 700;

SELECT COUNT(*) AS football_players_count
FROM students s
JOIN student_sport ss ON s.id = ss.student_id
JOIN sportGroups sg ON ss.sportGroup_id = sg.id
JOIN sports sp ON sg.sport_id = sp.id
WHERE sp.name = 'Football';

SELECT c.name AS coach_name, s.name AS sport_name
FROM coaches c
LEFT JOIN sportGroups sg ON c.id = sg.coach_id
LEFT JOIN sports s ON sg.sport_id = s.id;

SELECT s.name AS sport_name, sg.location AS training_location, COUNT(ss.student_id) AS student_count
FROM sportGroups sg
JOIN sports s ON sg.sport_id = s.id
JOIN student_sport ss ON sg.id = ss.sportGroup_id
GROUP BY sg.id
HAVING COUNT(ss.student_id) >= 3;

