use school_sport_clubs;

drop procedure if exists monthHonorariumPayment;

delimiter |
create procedure monthHonorariumPayment(IN monthOfPayment INT, in yearOFpayment INT)
procLabel: begin
declare countOfCoaches int;
declare iterator int;
declare countOfRowsBeforeUpdate int;
declare countOfRowsAfterUpdate int;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SELECT 'SQLException occured';


create temporary table tempCoaches(
id int auto_increment primary key,
coach_id int not null,
monthHourSum int
)Engine = Memory;


create temporary table tempTbl(
id int auto_increment primary key,
coach_id int,
number_of_hours int,
pay_for_hour decimal,
amount decimal,
paymentMonth int,
paymentYear int
)Engine = Memory;
	
	#Плащане на редовна месечна заплата:
    SET @RESULT =0;
	SELECt @RESULT; 
    call monthSalaryPayment(monthOfPayment,yearOFpayment,@RESULT);
    
   	SELECT COUNT(*)
    INTO countOfRowsBeforeUpdate
    FROM coach_work
	where month(coach_work.date) = monthOfPayment
	AND YEAR(coach_work.date) = yearOFpayment
    AND isPayed = 0;

INSERT INTO tempCoaches(coach_id, monthHourSum)  #записваме всички треньори и сумата от техните часове в табличка за дадения месец на дадената година
	SELECT  coach_id, SUM(number_of_hours)
	FROM coach_work
	where month(coach_work.date) = monthOfPayment
	AND YEAR(coach_work.date) = yearOFpayment
    AND isPayed = 0
	GROUP BY coach_work.coach_id;

	set iterator = 1;
	SELECT COUNT(*)
	INTO countOfCoaches
	FROM tempCoaches;

IF(ifnull(countOfCoaches,0) = 0) #Няма треньори, за които да се извършва плащане
	THEN SELECT 'No coaches and hours for this payment period';
		drop table tempTbl;
		drop table tempCoaches;
		LEAVE procLabel;
ELSE
	START TRANSACTION;
	WHILE(iterator >= 1 AND iterator <= countOfCoaches)
	DO
	INSERT INTO tempTbl(coach_id, number_of_hours, pay_for_hour, amount, paymentMonth,paymentYear)
	SELECT tc.coach_id, tc.monthHourSum, c.hour_salary, tc.monthHourSum*c.hour_salary, monthOfPayment, yearOFpayment
        FROM tempCoaches as tc JOIN coaches as c
	ON tc.coach_id = c.id
	WHERE tc.id = iterator;
	SET iterator = iterator + 1;

	END WHILE;
	
	INSERT INTO salarypayments(`coach_id`, `month`,`year`,`salaryAmount`,`dateOfPayment`)
        SELECT coach_id, paymentMonth, paymentYear, amount, NOW()
	FROM tempTbl
        ON DUPLICATE KEY UPDATE 
        salaryAmount = salaryAmount + amount,
        dateOfPayment = NOW();
         

	UPDATE coach_work
        SET isPayed = 1
	WHERE month(coach_work.date) = monthOfPayment
	AND YEAR(coach_work.date) = yearOFpayment
        AND isPayed = 0;
    
        SELECT  ROW_COUNT() INTO countOfRowsAfterUpdate;
    
       IF(countOfRowsBeforeUpdate = countOfRowsAfterUpdate)
      THEN 
		commit;
      ELSE
		rollback;
      END IF;
    
	drop table tempTbl;
	drop table tempCoaches;
END IF;
END
|
DELIMITER ;

call monthHonorariumPayment(4, 2024);