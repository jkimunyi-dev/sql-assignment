Create Database:



DBName: hotel_db

Tables:



guests (id, name, email, phone, check_in_date, check_out_date)



rooms (id, number, type, price_per_night, is_available)



bookings (id, guest_id, room_id, booking_date, nights, total_price)



services (id, name, price)



guest_services (id, guest_id, service_id, date_used)



Tasks to Implement

1️⃣ SQL Data Types & Basic SELECT



Insert at least 5 guests, 3 rooms, and 3 services.

Select guest names and phone numbers.



2️⃣ Modifying Data



Insert a new guest and a new booking.

Update a guest’s check-out date.

Delete a guest who checked out more than 1 month ago.



3️⃣ Filtering & Grouping



Find guests who booked after a specific date.

Group bookings by room_id and show average nights stayed.



4️⃣ Joins & Subqueries



List guests and the rooms they’re staying in (JOIN).

Subquery to find guests who have used more than 2 services.



5️⃣ Views & Pagination



Create a view showing guest name, room number, total price.

Paginate the view to show 3 bookings at a time (using LIMIT and OFFSET).



6️⃣ Sorting & Limiting



Sort guests by check-in date (descending).

Limit results to the 5 most recent guests.



7️⃣ Constraints & Expressions, SET Operators, CTEs



Add a UNIQUE constraint on email in guests.

Use CASE to categorize rooms (Economy, Business, Luxury) based on price_per_night.

Use a CTE to find rooms booked more than 3 times.

Use UNION to combine guests who booked a room or used a spa service.



8️⃣ Triggers & Indexes



Create a trigger to log updates to rooms availability.

Create an index on bookings.booking_date for faster lookups.



9️⃣ User Defined Functions & Stored Procedures



Create a function to calculate total spend for a guest.

Create a stored procedure to add a booking

Create a procedure to check in a new guest and book them into a room.



Deliverables

SQL file with:

(An sql file has an extension of .sql eg hotel_db.sql)



Table definitions

INSERT, UPDATE, DELETE statements

Views, CTEs, Triggers, Functions

Queries for each topic

