DELIMITER $$
CREATE PROCEDURE IncreaseBookPrices(IN ReaderId INT)
BEGIN
UPDATE book
SET price = price * 1.10
WHERE id IN(SELECT book_id from book_reader where reader_id = ReaderId);
END $$
DELIMITER ;

call IncreaseBookPrices(1);

select * from book;