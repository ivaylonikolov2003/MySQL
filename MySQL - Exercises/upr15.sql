use school_sport_clubs;
delete from salarypayments;
create trigger after_delete_information
after delete on salarypayments
for each row
insert into salarypayments_log( operation, 
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

SELECT * FROM salarypayments_log;