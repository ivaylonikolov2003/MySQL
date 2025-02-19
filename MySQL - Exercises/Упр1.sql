DROP DATABASE IF EXISTS sporClubs;
CREATE DATABASE sporClubs;
USE sporClubs;

CREATE TABLE sports(
id INT AUTO_INCREMENT PRIMARY KEY,
sportName VARCHAR(255) NOT NULL
);

CREATE TABLE coaches(
id INT AUTO_INCREMENT PRIMARY KEY,
coachName VARCHAR(255) NOT NULL,
egn VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE students(
id INT AUTO_INCREMENT PRIMARY KEY,
studentName VARCHAR(255) NOT NULL,
egn VARCHAR(10) NOT NULL UNIQUE,
address VARCHAR(255) NOT NULL,
phone VARCHAR(20) NULL DEFAULT NULL,
class VARCHAR(10) NULL DEFAULT NULL
);

CREATE TABLE sportGroups(
id INT AUTO_INCREMENT PRIMARY KEY,
location VARCHAR(255),
dayOfWeek ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'),
hourOfTraining TIME NOT NULL,
sport_id INT NULL,
coach_id INT NULL,
UNIQUE KEY(location, dayOfWeek, hourOfTraining),
CONSTRAINT FOREIGN KEY (sport_id) REFERENCES sports(id),
CONSTRAINT FOREIGN KEY (coach_id) REFERENCES coaches(id)
);

CREATE TABLE student_sport(
student_id INT NOT NULL,
sportGroup_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (student_id) REFERENCES students(id),
CONSTRAINT FOREIGN KEY (sportGroup_id) REFERENCES sportGroups(id),
PRIMARY KEY(student_id, sportGroup_id)
);
        
SELECT * FROM students WHERE studentName LIKE 'I%';

SELECT sportGroups.location, 
sportGroups.dayOfWeek, 
sportGroups.hourOfTraining, 
sports.sportName 
FROM sportGroups JOIN sports
ON sportGroups.sport_id = sports.id;

INSERT  INTO sportgroups(location,dayOfWeek,hourOfTraining,sport_id,coach_id)
VALUES('Sofia- Liylin 7','Sunday','09:00:00',2,2);

SELECT DISTINCT coaches.coachName, sports.sportName
FROM coaches 
JOIN sportGroups ON coaches.id = sportGroups.coach_id
JOIN sports ON sportGroups.sport_id = sports.id;

SELECT students.studentName, students.class, sportGroups.id
FROM students
JOIN student_sport ON students.id = student_sport.student_id 
JOIN sportGroups ON student_sport.sportGroup_id = sportGroups.id
WHERE sportGroups.id IN(SELECT sportGroup_id FROM student_sport WHERE sportGroup_id 
IN(SELECT id FROM sportGroups WHERE dayOfWeek = 'Monday' AND hourOfTraining = '08:00:00' AND coach_id 
IN(SELECT id FROM coaches WHERE coachName = 'Иван Тодоров Петров') 
AND sport_id = (SELECT id FROM sports WHERE sportName = 'Football')));