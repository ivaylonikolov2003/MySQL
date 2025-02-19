DROP DATABASE IF EXISTS Cinema;
CREATE DATABASE Cinema;
USE Cinema;

CREATE TABLE Cinema (
    cinema_id INT AUTO_INCREMENT PRIMARY KEY,
    cinema_name VARCHAR(255),
    location VARCHAR(255)
);

CREATE TABLE Hall (
    hall_id INT AUTO_INCREMENT PRIMARY KEY,
    cinema_id INT,
    hall_name VARCHAR(255),
    hall_status VARCHAR(255),
    FOREIGN KEY (cinema_id) REFERENCES Cinema(cinema_id)
);

CREATE TABLE Film (
    film_id INT AUTO_INCREMENT PRIMARY KEY,
    film_title VARCHAR(255),
    release_year INT,
    country VARCHAR(255)
);

CREATE TABLE Projection (
    projection_id INT AUTO_INCREMENT PRIMARY KEY,
    film_id INT,
    hall_id INT,
    start_time DATETIME,
    audience_count INT,
    FOREIGN KEY (film_id) REFERENCES Film(film_id),
    FOREIGN KEY (hall_id) REFERENCES Hall(hall_id)
);

SELECT c.cinema_name, h.hall_name, p.start_time
FROM Cinema c
JOIN Hall h ON c.cinema_id = h.cinema_id
JOIN Projection p ON h.hall_id = p.hall_id
JOIN Film f ON p.film_id = f.film_id
WHERE f.film_title = 'Final Destination 7'
AND h.hall_status IN ('VIP', 'Deluxe')
ORDER BY c.cinema_name ASC, h.hall_name ASC;

SELECT SUM(p.audience_count) AS total_audience
FROM Cinema c
JOIN Hall h ON c.cinema_id = h.cinema_id
JOIN Projection p ON h.hall_id = p.hall_id
JOIN Film f ON p.film_id = f.film_id
WHERE c.cinema_name = 'Arena Mladost'
AND h.hall_status = 'VIP'
AND f.film_title = 'Final Destination 7';


