USE school_sport_clubs;

DELIMITER $

CREATE PROCEDURE GetCoachInfo(IN coachName VARCHAR(255))
BEGIN
    SELECT 
        sp.name AS sport_name,
        sg.location,
        sg.dayOfWeek,
        sg.hourOfTraining,
        s.name AS student_name,
        s.phone
    FROM 
        coaches c
    JOIN sportGroups sg ON c.id = sg.coach_id
    JOIN sports sp ON sg.sport_id = sp.id
    JOIN student_sport ss ON sg.id = ss.sportGroup_id
    JOIN students s ON ss.student_id = s.id
    WHERE 
        c.name = coachName;
END $

DELIMITER ;
CALL GetCoachInfo('Ivan Todorov Petkov');