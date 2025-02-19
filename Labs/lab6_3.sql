USE transaction_test;
START TRANSACTION;

UPDATE customer_accounts
SET amount = amount - 50000
WHERE customer_id = (SELECT id FROM customers WHERE name = 'Stoyan Pavlov Pavlov') 
AND currency = 'BGN';

UPDATE customer_accounts
SET amount = amount + 50000
WHERE customer_id = (SELECT id FROM customers WHERE name = 'Ivan Petrov Iordanov') 
AND currency = 'BGN';

COMMIT;
