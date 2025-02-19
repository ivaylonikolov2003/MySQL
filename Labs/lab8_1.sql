use school_sport_clubs;
drop procedure if exists monthSalaryPayment;
delimiter |
create procedure monthSalaryPayment(IN monthOfPayment INT, in yearOFpayment INT, OUT success bit)
procLab: begin
    declare tempCoachSalary decimal;
    declare currentcoachSalary decimal;
    declare iterator int;
    declare countOfCoaches int;
    declare tempCoachId int;
    declare updatedSalaryCounter int;
    declare countOfCoachesWithoutMonthSalary int;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SELECT 'SQLException occured';

create temporary table tempCoach(
id int auto_increment primary key,
coach_id int not null,
month_salary int not null
)Engine = Memory;

INSERT INTO tempCoach(coach_id,month_salary)
    SELECT coaches.id, coaches.month_salary
    FROM coaches
    WHERE month_salary IS NOT NULL ;
    
    SELECT COUNT(*)
    INTO countOfCoaches
    FROM tempCoach;

    SET countOfCoachesWithoutMonthSalary = 0;
    set iterator = 1;
    WHILE(iterator >= 1 AND iterator <= countOfCoaches) # преброяваме колко са треньорите, които не са си полчуили заплатата все още.
	DO
	SELECT coach_id, month_salary
        INTO tempCoachId, tempCoachSalary
        FROM tempCoach
        where id = iterator;
        
        SELECT salaryAmount
        INTO  currentCoachSalary #има ли заплата вече преведена за този месец и тази година този треньор
        FROM salarypayments
        WHERE `month` = monthOfPayment
        AND `year` = yearOFpayment
        AND `coach_id` = tempCoachId;
        
    IF(IFNULL(currentCoachSalary,0) <= tempCoachSalary) 
THEN 
    SET countOfCoachesWithoutMonthSalary = countOfCoachesWithoutMonthSalary +1; 
 END IF; 
 SET iterator = iterator +1; 
 end while; 
IF(countOfCoachesWithoutMonthSalary = 0) # ако няма треньори, които си чакат превод на заплатата 
THEN 
   drop table tempCoach; 
   set success = 0; 
LEAVE procLab;  
 ELSE set iterator = 1;  
 SET updatedSalaryCounter = 0;  
 START TRANSACTION; 
 WHILE(iterator >= 1 AND iterator <= countOfCoaches)
	DO
	SELECT coach_id, month_salary
        INTO tempCoachId, tempCoachSalary
        FROM tempCoach
        where id = iterator;
        
        SELECT salaryAmount
        INTO  currentCoachSalary #има ли заплата вече преведена за този месец и тази година този треньор
        FROM salarypayments
        WHERE `month` = monthOfPayment
        AND `year` = yearOFpayment
        AND `coach_id` = tempCoachId;
        
        
	IF(IFNULL(currentCoachSalary,0) < tempCoachSalary)
	THEN
        INSERT INTO salarypayments(`coach_id`,`month`,`year`,`salaryAmount`,`dateOfPayment`) 
VALUES (tempCoachId, monthOfPayment,yearOFpayment, tempCoachSalary, NOW())
        ON duplicate key update   #ако вече хонорарите му са преведени, то към тези пари да се добави и месечната му заплата.
        salaryAmount = salaryAmount + tempCoachSalary,
        dateOfPayment = NOW();
        set updatedSalaryCounter = updatedSalaryCounter + 1;
   ELSE
        SELECT 'The coach has a month salary yet!';
   END IF;    
        SET iterator = iterator +1;
  end while;
	IF(countOfCoachesWithoutMonthSalary = updatedSalaryCounter) # преведени са толкова заплати, колкото е трябвало
	THEN 
          commit;
	  SET success = 1;
          drop table tempCoach;
    ELSE
	rollback;
	SET success = 0;
        drop table tempCoach;
     END if;   
END IF;
end
|
DELIMITER ;
call monthSalaryPayment(4, 2024);