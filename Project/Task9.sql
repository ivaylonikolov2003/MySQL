USE usercommdb;

DELIMITER $$

CREATE PROCEDURE UserDetails()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE u_username VARCHAR(255);
    DECLARE u_email VARCHAR(255);
    DECLARE curr_user CURSOR FOR SELECT username, email FROM users;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN curr_user;

    read_loop: LOOP
        FETCH curr_user INTO u_username, u_email;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SELECT u_username AS Username, u_email AS Email;
    END LOOP;

    CLOSE curr_user;
END$$

DELIMITER ;
CALL UserDetails();