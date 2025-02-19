DELIMITER $

CREATE PROCEDURE ConvertCurrency(
    IN amount DOUBLE,
    IN currentCurrency VARCHAR(10),
    IN targetCurrency VARCHAR(10),
    OUT convertedAmount DOUBLE
)
BEGIN
    DECLARE exchangeRate DOUBLE;
    
    IF currentCurrency = 'BGN' AND targetCurrency = 'EUR' THEN
        SET exchangeRate = 1.95583;
        SET convertedAmount = amount / exchangeRate;
    ELSEIF currentCurrency = 'EUR' AND targetCurrency = 'BGN' THEN
        SET exchangeRate = 1.95583;
        SET convertedAmount = amount * exchangeRate;
    ELSE
        SET convertedAmount = 0;
    END IF;
END$

DELIMITER ;

