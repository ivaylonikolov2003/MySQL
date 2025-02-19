USE propertyHub;

CREATE VIEW monthlyDeals AS
SELECT 
    c.name AS owner_name,
    c.phone AS contact_phone,
    p.location AS address,
    p.area AS area,
    p.price AS price,
    e.name AS broker_name
FROM properties p
JOIN customers c ON p.customerId = c.id
JOIN ads a ON a.propertyId = p.id
JOIN deals d ON a.dealId = d.id
JOIN employees e ON d.employeeId = e.id
WHERE p.area > 100
    AND MONTH(d.dealDate) = MONTH(CURRENT_DATE())
    AND YEAR(d.dealDate) = YEAR(CURRENT_DATE())
    AND p.typeId = (SELECT id FROM types WHERE typeName = 'house')
ORDER BY p.price DESC;
