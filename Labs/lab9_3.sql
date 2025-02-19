DELIMITER |
 
CREATE TRIGGER check_student_groups_trigger
BEFORE INSERT ON school_sport_clubs.student_sport
FOR EACH ROW
BEGIN
    DECLARE group_count INT;
    SELECT COUNT(*) INTO group_count
    FROM school_sport_clubs.student_sport
    WHERE student_id = NEW.student_id;
 
    IF group_count >= 2 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: This student is already assigned to two groups.';
    END IF;
END|
 
DELIMITER ;