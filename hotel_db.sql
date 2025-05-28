CREATE DATABASE hotel_db;

CREATE TABLE guests(
  id NOT NULL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  phone VARCHAR(255) NOT NULL,
  check_in_date TIMESTAMP,
  check_out_date TIMESTAMP.
)

CREATE TABLE rooms(
  id PRIMARY KEY NOT NULL,
  name VARCHAR(255) NOT NULL,
  TYPE VARCHAR(255) NOT NULL,
  price_per_night INT NOT NULL,
  is_available BOOLEAN NOT NULL
)

CREATE TABLLE bookings(
  id VARCHAR(255) NOT NULL PRIMARY KEY,
  guest_id VARCHAR(255) NOT NULL,
  room_id VARCHAR(255) NOT NULL,
  booking_date DATE NOT NULL,
  nights INT NOT NULL,
  total_price INT NOT NULL
)

CREATE TABLES services(
  id VARCHAR(255) NOT NULL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  price INT NOT NULL,
)

CREATE TABLES guest_services(
  id VARCHAR(255) PRIMARY KEY NOT NULL,
  guest_id VARCHAR(255) NOT NULL,
  service_id VARCHAR(255) NOT NULL,
  date_used DATE NOT NULL,
)

INSERT INTO guests (id, name, email, phone, check_in_date, check_out_date) VALUES
('g1', 'Alice Kim', 'alice@example.com', '0712345678', '2025-05-25 14:00:00', '2025-05-28 12:00:00'),
('g2', 'Brian Ouko', 'brian@example.com', '0723456789', '2025-05-26 15:00:00', '2025-05-29 11:00:00'),
('g3', 'Cynthia Njeri', 'cynthia@example.com', '0734567890', '2025-05-24 16:00:00', '2025-05-27 10:00:00'),
('g4', 'David Otieno', 'david@example.com', '0745678901', '2025-05-23 13:00:00', '2025-05-26 09:00:00'),
('g5', 'Emily Wanjiku', 'emily@example.com', '0756789012', '2025-05-27 14:30:00', '2025-05-30 12:00:00');


INSERT INTO rooms(id, number, type, price_per_night,is_available) VALUES
('r1', 'Deluxe Room 101', 'Deluxe', 7500, TRUE),
('r2', 'Standard Room 102', 'Standard', 5000, FALSE),
('r3', 'Suite Room 103', 'Suite', 12000, TRUE);

INSERT INTO services(id ,name , price) VALUES
('s1', 'Spa Treatment', 3000),
('s2', 'Room Service', 1500),
('s3', 'Laundry', 1000);


SELECT name , phone from guests;