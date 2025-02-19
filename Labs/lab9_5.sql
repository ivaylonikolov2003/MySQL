DELIMITER |
 
CREATE PROCEDURE GetStudentsByCoach(IN coach_name VARCHAR(255))
BEGIN
    SELECT 
        st.name AS student_name, 
        sg.id AS group_id, 
        sp.name AS sport_name
    FROM 
        school_sport_clubs.coaches c
    INNER JOIN 
        school_sport_clubs.sportGroups sg ON c.id = sg.coach_id
    INNER JOIN 
        school_sport_clubs.student_sport ss ON sg.id = ss.sportGroup_id
    INNER JOIN 
        school_sport_clubs.students st ON ss.student_id = st.id
    INNER JOIN 
        school_sport_clubs.sports sp ON sg.sport_id = sp.id
    WHERE 
        c.name = coach_name;
END|
 
DELIMITER ;