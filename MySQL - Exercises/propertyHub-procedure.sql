DELIMITER $$

CREATE PROCEDURE commissionPayment(IN monthInput INT, IN yearInput INT)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE dealId INT;
    DECLARE propertyPrice DECIMAL(10, 2);
    DECLARE employeeId INT;
    DECLARE commission DECIMAL(10, 2);
    DECLARE averageCommission DECIMAL(10, 2);
    DECLARE bonus1 DECIMAL(10, 2);
    DECLARE bonus2 DECIMAL(10, 2);
    DECLARE bonus3 DECIMAL(10, 2);

    -- Курсор за обхождане на сделките
    DECLARE dealsCursor CURSOR FOR 
        SELECT d.id, p.price, d.employeeId 
        FROM deals d
        JOIN properties p ON d.id = p.id
        WHERE MONTH(d.dealDate) = monthInput AND YEAR(d.dealDate) = yearInput AND d.paymentType = 'sale';

    -- Обработка на изключения
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Започване на трансакция
    START TRANSACTION;

    -- Отваряне на курсора
    OPEN dealsCursor;

    read_loop: LOOP
        FETCH dealsCursor INTO dealId, propertyPrice, employeeId;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Изчисляване на комисионната
        IF propertyPrice <= 100000 THEN
            SET commission = propertyPrice * 0.02;
        ELSE
            SET commission = propertyPrice * 0.03;
        END IF;

        -- Обновяване на salaryPayments
        UPDATE salaryPayments
        SET monthlyBonus = monthlyBonus + commission
        WHERE employeeId = employeeId AND monthOfPayment = monthInput AND yearOfPayment = yearInput;
    END LOOP;

    -- Затваряне на курсора
    CLOSE dealsCursor;

    -- Изчисляване на средната комисионна и бонусите
    SELECT AVG(monthlyBonus) INTO averageCommission
    FROM salaryPayments
    WHERE monthOfPayment = monthInput AND yearOfPayment = yearInput;

    SET bonus1 = averageCommission * 0.15;
    SET bonus2 = averageCommission * 0.10;
    SET bonus3 = averageCommission * 0.05;

    -- Добавяне на бонусите към първите три служители с най-много продажби
    UPDATE salaryPayments
    SET monthlyBonus = monthlyBonus + bonus1
    WHERE employeeId = (SELECT employeeId FROM (SELECT employeeId, COUNT(*) AS totalSales FROM deals WHERE MONTH(dealDate) = monthInput AND YEAR(dealDate) = yearInput GROUP BY employeeId ORDER BY totalSales DESC LIMIT 1) AS top1);

    UPDATE salaryPayments
    SET monthlyBonus = monthlyBonus + bonus2
    WHERE employeeId = (SELECT employeeId FROM (SELECT employeeId, COUNT(*) AS totalSales FROM deals WHERE MONTH(dealDate) = monthInput AND YEAR(dealDate) = yearInput GROUP BY employeeId ORDER BY totalSales DESC LIMIT 1, 1) AS top2);

    UPDATE salaryPayments
    SET monthlyBonus = monthlyBonus + bonus3
    WHERE employeeId = (SELECT employeeId FROM (SELECT employeeId, COUNT(*) AS totalSales FROM deals WHERE MONTH(dealDate) = monthInput AND YEAR(dealDate) = yearInput GROUP BY employeeId ORDER BY totalSales DESC LIMIT 2, 1) AS top3);

    -- Приключване на трансакцията
    COMMIT;
END$$

DELIMITER ;
