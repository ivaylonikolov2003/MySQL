CREATE VIEW coach_salary_details AS
SELECT 
    c.name AS coach_name,
    s.name AS sport_name,
    CONCAT(sg.id, ' - ', sg.location) AS groupInfo,
    sp.year,
    sp.month,
    sp.salaryAmount
FROM 
    coaches c
JOIN 
    sportGroups sg ON c.id = sg.coach_id
JOIN 
    sports s ON sg.sport_id = s.id
JOIN 
    salaryPayments sp ON c.id = sp.coach_id
WHERE 
    sp.year = year(now()) AND sp.month = month(now());

select * from coach_salary_details