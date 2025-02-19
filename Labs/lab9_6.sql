DELIMITER |
 
CREATE PROCEDURE GetCoachesBySport(IN sport_name VARCHAR(255))
BEGIN
    SELECT 
        c.name AS coach_name,
        sg.location AS training_location,
        sg.hourOfTraining AS training_time,
        sg.dayOfWeek AS training_day
    FROM 
        school_sport_clubs.coaches c
    INNER JOIN 
        school_sport_clubs.sportGroups sg ON c.id = sg.coach_id
    INNER JOIN 
        school_sport_clubs.sports sp ON sg.sport_id = sp.id
    WHERE 
        sp.name = sport_name;
END|
 
DELIMITER ;