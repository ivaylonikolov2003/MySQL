DELIMITER $$
CREATE PROCEDURE publishersBooks()
BEGIN
SELECT publisher.id, publisher.name, COUNT(book.id) as books
FROM publisher
JOIN book on publisher.id = book.publisher_id
group by publisher.id, publisher.name
having COUNT(book.id)  > 2;
END $$
DELIMITER ;

INSERT INTO book (ISBN, title, price, category, publisher_id) VALUES
('978-3-16-148', 'Introduction to Algorithms', 450, 'Education', 1),
('978-0-13-235', 'Clean Code', 650, 'Software', 2),
('978-0-201-63', 'Design Patterns', 500, 'Software', 2),
('978-1-491-99', 'Fluent Python', 700, 'Programming', 3),
('978-1-593-27', 'You Don’t Know JS', 375, 'Programming', 4);

call publishersBooks();
