
CREATE DATABASE hotel_db;
USE hotel_db;

CREATE TABLE guests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    check_in_date DATE,
    check_out_date DATE
);


CREATE TABLE rooms (
    id INT PRIMARY KEY AUTO_INCREMENT,
    number VARCHAR(10) UNIQUE NOT NULL,
    type ENUM('Single', 'Double', 'Suite', 'Deluxe') NOT NULL,
    price_per_night DECIMAL(10,2) NOT NULL,
    is_available BOOLEAN DEFAULT TRUE
);


CREATE TABLE bookings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT NOT NULL,
    room_id INT NOT NULL,
    booking_date DATE NOT NULL,
    nights INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
);


CREATE TABLE services (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);


CREATE TABLE guest_services (
    id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT NOT NULL,
    service_id INT NOT NULL,
    date_used DATE NOT NULL,
);

INSERT INTO guests (name, email, phone, check_in_date, check_out_date) VALUES
('Grace Wanjiku Kamau', 'grace.wanjiku@gmail.com', '+254722123456', '2024-12-01', '2024-12-05'),
('David Kiprotich Koech', 'david.koech@yahoo.com', '+254733987654', '2024-11-28', '2024-12-02'),
('Faith Akinyi Odhiambo', 'faith.akinyi@hotmail.com', '+254711456789', '2024-12-03', '2024-12-08'),
('Samuel Mwangi Njoroge', 'samuel.mwangi@gmail.com', '+254700234567', '2024-12-05', NULL),
('Rebecca Chebet Rono', 'rebecca.chebet@outlook.com', '+254788345678', '2024-12-02', '2024-12-07'),
('Joseph Makau Mutua', 'joseph.makau@gmail.com', '+254755567890', '2024-11-15', '2024-11-20'),
('Mary Nyawira Gichuki', 'mary.nyawira@yahoo.com', '+254766678901', '2024-12-04', NULL),
('Peter Otieno Omondi', 'peter.otieno@gmail.com', '+254777789012', '2024-12-01', '2024-12-06');


INSERT INTO rooms (number, type, price_per_night, is_available) VALUES
('101', 'Single', 3500.00, TRUE),
('102', 'Double', 5500.00, FALSE),
('201', 'Suite', 12000.00, TRUE),
('202', 'Deluxe', 15000.00, FALSE),
('103', 'Double', 5800.00, TRUE),
('301', 'Suite', 11500.00, TRUE),
('302', 'Deluxe', 16000.00, TRUE);


INSERT INTO services (name, price) VALUES
('Spa Treatment', 4500.00),
('Airport Transfer', 2500.00),
('Laundry Service', 800.00),
('Room Service', 1200.00),
('Gym Access', 500.00),
('Conference Room', 8000.00);


INSERT INTO bookings (guest_id, room_id, booking_date, nights, total_price) VALUES
(1, 2, '2024-12-01', 4, 22000.00),
(2, 4, '2024-11-28', 5, 75000.00),
(3, 1, '2024-12-03', 5, 17500.00),
(4, 3, '2024-12-05', 3, 36000.00),
(5, 5, '2024-12-02', 5, 29000.00),
(7, 6, '2024-12-04', 4, 46000.00),
(8, 7, '2024-12-01', 5, 80000.00);


INSERT INTO guest_services (guest_id, service_id, date_used) VALUES
(1, 1, '2024-12-02'),
(1, 3, '2024-12-03'),
(1, 4, '2024-12-04'),
(2, 2, '2024-11-28'),
(2, 1, '2024-11-30'),
(3, 5, '2024-12-04'),
(3, 3, '2024-12-05'),
(3, 4, '2024-12-06'),
(4, 1, '2024-12-06'),
(5, 2, '2024-12-07'),
(7, 6, '2024-12-05'),
(8, 1, '2024-12-02'),
(8, 2, '2024-12-06');






SELECT name, phone FROM guests;






INSERT INTO guests (name, email, phone, check_in_date) VALUES
('Anne Wanjiru Kariuki', 'anne.wanjiru@gmail.com', '+254799123456', '2024-12-10');


INSERT INTO bookings (guest_id, room_id, booking_date, nights, total_price) VALUES
(LAST_INSERT_ID(), 1, '2024-12-10', 3, 10500.00);


UPDATE guests 
SET check_out_date = '2024-12-09' 
WHERE name = 'Samuel Mwangi Njoroge';


DELETE FROM guests 
WHERE check_out_date < DATE_SUB(CURDATE(), INTERVAL 1 MONTH);






SELECT g.name, g.email, b.booking_date
FROM guests g
JOIN bookings b ON g.id = b.guest_id
WHERE b.booking_date > '2024-12-01';


SELECT 
    room_id,
    r.number as room_number,
    AVG(nights) as avg_nights_stayed,
    COUNT(*) as total_bookings
FROM bookings b
JOIN rooms r ON b.room_id = r.id
GROUP BY room_id, r.number
ORDER BY avg_nights_stayed DESC;






SELECT 
    g.name as guest_name,
    g.phone,
    r.number as room_number,
    r.type as room_type,
    b.nights,
    b.total_price
FROM guests g
JOIN bookings b ON g.id = b.guest_id
JOIN rooms r ON b.room_id = r.id
ORDER BY g.name;


SELECT 
    g.name,
    g.email,
    (SELECT COUNT(*) FROM guest_services gs WHERE gs.guest_id = g.id) as services_count
FROM guests g
WHERE (
    SELECT COUNT(*) 
    FROM guest_services gs 
    WHERE gs.guest_id = g.id
) > 2;






CREATE VIEW booking_summary AS
SELECT 
    g.name as guest_name,
    r.number as room_number,
    r.type as room_type,
    b.nights,
    b.total_price,
    b.booking_date
FROM guests g
JOIN bookings b ON g.id = b.guest_id
JOIN rooms r ON b.room_id = r.id;



SELECT * FROM booking_summary 
ORDER BY booking_date DESC 
LIMIT 3 OFFSET 0;


SELECT * FROM booking_summary 
ORDER BY booking_date DESC 
LIMIT 3 OFFSET 3;






SELECT name, check_in_date, check_out_date
FROM guests
WHERE check_in_date IS NOT NULL
ORDER BY check_in_date DESC;


SELECT name, check_in_date, email
FROM guests
WHERE check_in_date IS NOT NULL
ORDER BY check_in_date DESC
LIMIT 5;









SELECT 
    number,
    type,
    price_per_night,
    CASE 
        WHEN price_per_night < 5000 THEN 'Economy'
        WHEN price_per_night BETWEEN 5000 AND 10000 THEN 'Business'
        ELSE 'Luxury'
    END as category
FROM rooms
ORDER BY price_per_night;






WITH room_booking_count AS (
    SELECT 
        r.id,
        r.number,
        r.type,
        COUNT(b.id) as booking_count
    FROM rooms r
    LEFT JOIN bookings b ON r.id = b.room_id
    GROUP BY r.id, r.number, r.type
)
SELECT * FROM room_booking_count 
WHERE booking_count > 1;


(SELECT DISTINCT g.name, g.email, 'Room Booking' as activity_type
 FROM guests g
 JOIN bookings b ON g.id = b.guest_id)
UNION
(SELECT DISTINCT g.name, g.email, 'Spa Service' as activity_type
 FROM guests g
 JOIN guest_services gs ON g.id = gs.guest_id
 JOIN services s ON gs.service_id = s.id
 WHERE s.name = 'Spa Treatment');






DELIMITER //
CREATE TRIGGER log_room_availability_update
    AFTER UPDATE ON rooms
    FOR EACH ROW
BEGIN
    IF OLD.is_available != NEW.is_available THEN
        INSERT INTO room_updates_log (room_id, old_availability, new_availability)
        VALUES (NEW.id, OLD.is_available, NEW.is_available);
    END IF;
END;//
DELIMITER ;


UPDATE rooms SET is_available = FALSE WHERE number = '101';
UPDATE rooms SET is_available = TRUE WHERE number = '101';


CREATE INDEX idx_booking_date ON bookings(booking_date);


CREATE INDEX idx_guest_email ON guests(email);
CREATE INDEX idx_room_number ON rooms(number);






DELIMITER //
CREATE FUNCTION calculate_guest_total_spend(guest_id_param INT) 
RETURNS DECIMAL(10,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE total_bookings DECIMAL(10,2) DEFAULT 0;
    DECLARE total_services DECIMAL(10,2) DEFAULT 0;
    DECLARE total_spend DECIMAL(10,2) DEFAULT 0;
    
    
    SELECT COALESCE(SUM(total_price), 0) INTO total_bookings
    FROM bookings 
    WHERE guest_id = guest_id_param;
    
    
    SELECT COALESCE(SUM(s.price), 0) INTO total_services
    FROM guest_services gs
    JOIN services s ON gs.service_id = s.id
    WHERE gs.guest_id = guest_id_param;
    
    SET total_spend = total_bookings + total_services;
    
    RETURN total_spend;
END;//
DELIMITER ;


SELECT 
    name,
    calculate_guest_total_spend(id) as total_spend
FROM guests
WHERE id IN (1, 2, 3);






DELIMITER //
CREATE PROCEDURE add_booking(
    IN p_guest_id INT,
    IN p_room_id INT,
    IN p_booking_date DATE,
    IN p_nights INT
)
BEGIN
    DECLARE room_price DECIMAL(10,2);
    DECLARE calculated_total DECIMAL(10,2);
    DECLARE room_available BOOLEAN;
    
    
    SELECT is_available, price_per_night 
    INTO room_available, room_price
    FROM rooms 
    WHERE id = p_room_id;
    
    IF room_available = FALSE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Room is not available';
    END IF;
    
    
    SET calculated_total = room_price * p_nights;
    
    
    INSERT INTO bookings (guest_id, room_id, booking_date, nights, total_price)
    VALUES (p_guest_id, p_room_id, p_booking_date, p_nights, calculated_total);
    
    
    UPDATE rooms SET is_available = FALSE WHERE id = p_room_id;
    
END;//
DELIMITER ;


DELIMITER //
CREATE PROCEDURE checkin_new_guest(
    IN p_name VARCHAR(100),
    IN p_email VARCHAR(150),
    IN p_phone VARCHAR(15),
    IN p_room_number VARCHAR(10),
    IN p_nights INT
)
BEGIN
    DECLARE new_guest_id INT;
    DECLARE room_id_found INT;
    DECLARE room_available BOOLEAN;
    DECLARE room_price DECIMAL(10,2);
    
    
    SELECT id, is_available, price_per_night 
    INTO room_id_found, room_available, room_price
    FROM rooms 
    WHERE number = p_room_number;
    
    IF room_id_found IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Room number not found';
    END IF;
    
    IF room_available = FALSE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Room is not available';
    END IF;
    
    
    INSERT INTO guests (name, email, phone, check_in_date)
    VALUES (p_name, p_email, p_phone, CURDATE());
    
    SET new_guest_id = LAST_INSERT_ID();
    
    
    CALL add_booking(new_guest_id, room_id_found, CURDATE(), p_nights);
    
    
    SELECT 
        new_guest_id as guest_id,
        p_name as guest_name,
        p_room_number as room_number,
        p_nights as nights,
        (room_price * p_nights) as total_price;
        
END;//
DELIMITER ;






CALL add_booking(1, 1, '2024-12-15', 2);


CALL checkin_new_guest(
    'John Kamau Githuka', 
    'john.kamau@gmail.com', 
    '+254766123789', 
    '301', 
    4
);






SELECT 
    g.name,
    g.email,
    COUNT(DISTINCT b.id) as total_bookings,
    COUNT(DISTINCT gs.id) as total_services_used,
    calculate_guest_total_spend(g.id) as total_spent
FROM guests g
LEFT JOIN bookings b ON g.id = b.guest_id
LEFT JOIN guest_services gs ON g.id = gs.guest_id
GROUP BY g.id, g.name, g.email
ORDER BY total_spent DESC;


SELECT 
    r.number,
    r.type,
    r.price_per_night,
    COUNT(b.id) as times_booked,
    COALESCE(SUM(b.total_price), 0) as total_revenue,
    CASE WHEN r.is_available THEN 'Available' ELSE 'Occupied' END as current_status
FROM rooms r
LEFT JOIN bookings b ON r.id = b.room_id
GROUP BY r.id, r.number, r.type, r.price_per_night, r.is_available
ORDER BY total_revenue DESC;


SELECT 
    s.name,
    s.price,
    COUNT(gs.id) as times_used,
    COUNT(DISTINCT gs.guest_id) as unique_guests,
    SUM(s.price) as total_revenue
FROM services s
LEFT JOIN guest_services gs ON s.id = gs.service_id
GROUP BY s.id, s.name, s.price
ORDER BY times_used DESC;


SELECT 
    DATE_FORMAT(booking_date, '%Y-%m') as booking_month,
    COUNT(*) as total_bookings,
    SUM(total_price) as total_revenue,
    AVG(nights) as avg_nights_stayed
FROM bookings
GROUP BY DATE_FORMAT(booking_date, '%Y-%m')
ORDER BY booking_month;


SELECT * FROM room_updates_log ORDER BY update_timestamp DESC;






SHOW TABLES;
SHOW TRIGGERS;










