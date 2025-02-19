DELIMITER $

CREATE PROCEDURE AverageFeesByStudent(IN studentName VARCHAR(255), IN year INT)
BEGIN
    SELECT AVG(paymentAmount) AS 'Average'
    FROM taxespayments tp
    JOIN students s ON tp.student_id = s.id
    WHERE s.name = studentName AND YEAR(tp.dateOfPayment) = year;
END $

DELIMITER ;

CALL AverageFeesByStudent('Iliyan Ivanov', 2024);