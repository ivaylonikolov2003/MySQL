DELIMITER $

CREATE PROCEDURE GetStudentsInMultipleGroups()
BEGIN
    SELECT 
        s.name
    FROM 
        students s
    JOIN 
        student_sport ss ON s.id = ss.student_id
    GROUP BY 
        s.id
    HAVING 
        COUNT(ss.sportGroup_id) > 1;
END$

DELIMITER ;

CALL GetStudentsInMultipleGroups();