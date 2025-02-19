USE school_sport_clubs;
DELIMITER $$

CREATE TRIGGER log_salarypayments_delete
AFTER DELETE ON salarypayments
FOR EACH ROW
BEGIN
    INSERT INTO salarypayments_log (
        operation, 
        old_coach_id,
        old_month, 
        old_year, 
        old_salaryAmount,
        old_dateOfPayment, 
        dateOfLog
    ) VALUES (
        'DELETE', 
        OLD.coach_id, 
        OLD.month, 
        OLD.year, 
        OLD.salaryAmount, 
        OLD.dateOfPayment, 
        NOW()
    );
END$$

DELIMITER ;

SELECT * FROM salarypayments_log;


