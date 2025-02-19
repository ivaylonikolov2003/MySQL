DELIMITER $

CREATE PROCEDURE transfer_funds (
    IN sender_id INT,
    IN recipient_id INT,
    IN transfer_amount DOUBLE
)
BEGIN
    DECLARE sender_balance DOUBLE;
    DECLARE recipient_balance DOUBLE;

    SELECT amount INTO sender_balance FROM customer_accounts WHERE id = sender_id;
    SELECT amount INTO recipient_balance FROM customer_accounts WHERE id = recipient_id;

    IF sender_balance >= transfer_amount THEN
        START TRANSACTION;
        UPDATE customer_accounts SET amount = amount - transfer_amount WHERE id = sender_id;
        UPDATE customer_accounts SET amount = amount + transfer_amount WHERE id = recipient_id;
        
        IF ROW_COUNT() = 1 THEN
            COMMIT;
            SELECT 'Transfer successful' AS message;
        ELSE
            ROLLBACK;
            SELECT 'Transaction failed' AS message;
        END IF;
    ELSE
        SELECT 'Insufficient funds' AS message;
    END IF;
END $

DELIMITER ;
CALL transfer_funds(1, 2, 1000);
select * from customer_accounts;