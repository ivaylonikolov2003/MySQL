DELIMITER $$
CREATE PROCEDURE sumOfBooks()
BEGIN
SELECT reader.id, reader.first_name, reader.last_name, SUM(book.price) as sumBooks
from reader
join book_reader on reader.id = book_reader.reader_id
join book on book_reader.book_id = book.id
group by reader.id, reader.first_name, reader.last_name;
END $$
DELIMITER ;

call sumOfBooks();

