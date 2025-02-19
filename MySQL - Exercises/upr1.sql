DELIMITER $$
CREATE PROCEDURE bookPublisherSelect()
BEGIN
SELECT book.title, publisher.name
FROM book
LEFT JOIN publisher on book.publisher_id = publisher_id;
END $$
DELIMITER ;

CALL bookPublisherSelect();

DELIMITER /
CREATE PROCEDURE testParam(IN nameParam VARCHAR(255))
BEGIN
SELECT nameParam;
SET nameParam = 'Hachette Livre';
END /
DELIMITER ;

SET @publisherName = "Pearson";
SELECT @publisherName;
CALL testParam(@publisherName);
SELECT @publisherName;