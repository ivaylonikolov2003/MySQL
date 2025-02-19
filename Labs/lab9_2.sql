DELETE FROM salarypayments;
INSERT INTO salarypayments (coach_id, month, year, salaryAmount, dateOfPayment)
SELECT old_coach_id, old_month, old_year, old_salaryAmount, old_dateOfPayment
FROM salarypayments_log
WHERE operation = 'DELETE';

SELECT * FROM salarypayments;