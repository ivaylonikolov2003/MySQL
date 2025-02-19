DELIMITER $

CREATE PROCEDURE GetSportInfo(IN sportID INT)
BEGIN
    SELECT 
        s.name AS sport_name,
        st.name AS student_name,
        c.name AS coach_name
    FROM 
        sports s
    JOIN sportGroups sg ON s.id = sg.sport_id
    JOIN coaches c ON sg.coach_id = c.id
    JOIN student_sport ss ON sg.id = ss.sportGroup_id
    JOIN students st ON ss.student_id = st.id
    WHERE 
        s.id = sportID;
END $

DELIMITER ;
CALL GetSportInfo(1);