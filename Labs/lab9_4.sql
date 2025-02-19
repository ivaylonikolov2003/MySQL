CREATE VIEW student_training_groups AS
SELECT s.name AS student_name, s.egn AS student_egn, COUNT(ss.student_id) AS training_groups_count
FROM school_sport_clubs.students s
LEFT JOIN school_sport_clubs.student_sport ss ON s.id = ss.student_id
GROUP BY s.id;