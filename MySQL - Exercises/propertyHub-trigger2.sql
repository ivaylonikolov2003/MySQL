DELIMITER $$

CREATE TRIGGER checkRentalAdsLimit
BEFORE INSERT ON ads
FOR EACH ROW
BEGIN
    DECLARE rental_ads_count INT;

    SELECT COUNT(*) INTO rental_ads_count
    FROM ads
    JOIN properties ON ads.propertyId = properties.id
    WHERE properties.customerId = (SELECT customerId FROM properties WHERE id = NEW.propertyId)
          AND ads.isActual = TRUE
          AND ads.dealId IS NULL; 

    IF rental_ads_count >= 2 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Each customer can have only two active rental ads.';
    END IF;
END$$

DELIMITER ;
