use soft_uni;
delimiter $$
CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(20))
RETURNS DOUBLE DETERMINISTIC READS SQL DATA
BEGIN
DECLARE e_count double;
SET e_count := (SELECT COUNT(employee_id) FROM employees AS e
INNER JOIN addresses AS a ON a.address_id = e.address_id
INNER JOIN towns AS t ON t.town_id = a.town_id
WHERE t.name = town_name);
RETURN e_count;
END$$

delimiter ;

SELECT ufn_count_employees_by_town('Sofia');