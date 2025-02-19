DELIMITER $
CREATE PROCEDURE GetCoachGroupCount(IN coachName VARCHAR(255))
BEGIN
    DECLARE coachID INT;
    
    SELECT id INTO coachID
    FROM coaches
    WHERE name = coachName;
    
    IF coachID IS NOT NULL THEN
        SELECT COUNT(*) AS group_count
        FROM sportGroups
        WHERE coach_id = coachID;
    ELSE
        SELECT 'Coach not found' AS message;
    END IF;
END $
DELIMITER ;
CALL GetCoachGroupCount('Ivan Todorov Petkov');