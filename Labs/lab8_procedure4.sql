DELIMITER $

CREATE PROCEDURE TransferMoney(
    IN senderID INT,
    IN receiverID INT,
    IN transferAmount DOUBLE
)
BEGIN
    DECLARE senderCurrency VARCHAR(10);
    DECLARE receiverCurrency VARCHAR(10);
    DECLARE senderBalance DOUBLE;
    DECLARE convertedAmount DOUBLE;
    
    START TRANSACTION;
    
    SELECT currency INTO senderCurrency FROM customer_accounts WHERE customer_id = senderID FOR UPDATE;
    SELECT currency INTO receiverCurrency FROM customer_accounts WHERE customer_id = receiverID FOR UPDATE;
    
    IF (senderCurrency = 'BGN' OR senderCurrency = 'EUR') AND (receiverCurrency = 'BGN' OR receiverCurrency = 'EUR') THEN
        IF senderCurrency != receiverCurrency THEN
            CALL ConvertCurrency(transferAmount, senderCurrency, receiverCurrency, convertedAmount);
            SET transferAmount = convertedAmount;
        END IF;
        
        SELECT amount INTO senderBalance FROM customer_accounts WHERE customer_id = senderID FOR UPDATE;
        IF senderBalance >= transferAmount THEN
            UPDATE customer_accounts SET amount = amount - transferAmount WHERE customer_id = senderID;
            UPDATE customer_accounts SET amount = amount + transferAmount WHERE customer_id = receiverID;
            COMMIT;
            SELECT 'Трансакцията е успешна.' AS Message;
        ELSE
            ROLLBACK;
            SELECT 'Няма достатъчно средства на изпращача за тази трансакция.' AS Error;
        END IF;
    ELSE
        ROLLBACK;
        SELECT 'Грешка: Валутите на сметките трябва да са в BGN или EUR.' AS Error;
    END IF;
END$

DELIMITER ;
