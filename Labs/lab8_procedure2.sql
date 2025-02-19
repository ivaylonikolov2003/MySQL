DELIMITER $

CREATE PROCEDURE GetCoachesWithoutGroups()
BEGIN
    SELECT 
        c.name AS coach_name
    FROM 
        coaches c
    LEFT JOIN 
        sportGroups sg ON c.id = sg.coach_id
    WHERE 
        sg.id IS NULL;
END$

DELIMITER ;

CALL GetCoachesWithoutGroups();
