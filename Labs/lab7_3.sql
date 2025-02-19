use school_sport_clubs;
#drop procedure checkMothTax;
delimiter |
CREATE procedure checkMothTax(IN studId INT, IN groupId INT, IN paymentMonth INT, IN paymentYear INT)
BEGIN
DECLARE result char(1);
SET result = 0;
	IF( (SELECT paymentAmount
		FROM taxespayments
		WHERE student_id = studId
		AND group_id = groupId
		AND MONTH = paymentMonth
		AND year = paymentYear) IS NOT NULL)
    THEN
		SET result = 1;
	ELSE
		SET result = 0;
    END IF;
    
SELECT result as IsTaxPayed;
end;
|
delimiter ;
CALL `school_sport_clubs`.`checkMothTax`(1, 1,1,2022);