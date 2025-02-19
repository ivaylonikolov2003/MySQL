delimiter $$
create procedure getStudentInfo(IN StudName varchar(255), IN taxes int)
begin
select students.name, avg(paymentAmount) as payment
from taxespayments
join students on taxespayments.student_id = students.id
where students.name = StudName and YEAR(taxespayments.dateOfPayment) = taxes
group by students.name;
end $$
delimiter ;

CALL getStudentInfo('Iliyan Ivanov', 2024);

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