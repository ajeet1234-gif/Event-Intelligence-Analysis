-- Event Intelligence Dataset - MySQL Import Script
-- Generated for MySQL 8.x / MySQL Workbench
-- IMPORTANT: update DATA_DIR below if your CSV files are stored elsewhere.
-- Recommended: enable LOCAL INFILE for the MySQL connection.

CREATE DATABASE IF NOT EXISTS event_intelligence;
USE event_intelligence;

SET FOREIGN_KEY_CHECKS = 0;


CREATE TABLE event_categories (
    category_id INT NOT NULL,
    category_code VARCHAR(100),
    category_name VARCHAR(255),
    parent_category VARCHAR(255),
    PRIMARY KEY (category_id)
);

CREATE TABLE organizers (
    organizer_id INT NOT NULL,
    organizer_code VARCHAR(100),
    organizer_name VARCHAR(255),
    organizer_type VARCHAR(100),
    city VARCHAR(100),
    years_in_business DECIMAL(10,2),
    contact_email VARCHAR(255),
    PRIMARY KEY (organizer_id)
);

CREATE TABLE venues (
    venue_id INT NOT NULL,
    venue_code VARCHAR(100),
    venue_name VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    venue_type VARCHAR(100),
    capacity INT,
    indoor_outdoor VARCHAR(50),
    metro_distance_km DECIMAL(10,2),
    parking_capacity DECIMAL(10,2),
    PRIMARY KEY (venue_id)
);

CREATE TABLE customers (
    customer_id INT NOT NULL,
    customer_email VARCHAR(255),
    customer_name VARCHAR(255),
    age DECIMAL(5,2),
    gender VARCHAR(50),
    city VARCHAR(100),
    state VARCHAR(100),
    registration_date DATE,
    customer_segment VARCHAR(100),
    PRIMARY KEY (customer_id)
);

CREATE TABLE events (
    event_id INT NOT NULL,
    event_code VARCHAR(100),
    event_name VARCHAR(255),
    category_id INT,
    venue_id INT,
    organizer_id INT,
    event_date DATE,
    start_time TIME,
    end_time TIME,
    expected_attendance INT,
    base_ticket_price DECIMAL(12,2),
    event_status VARCHAR(100),
    PRIMARY KEY (event_id),
    CONSTRAINT fk_events_category FOREIGN KEY (category_id) REFERENCES event_categories(category_id),
    CONSTRAINT fk_events_venue FOREIGN KEY (venue_id) REFERENCES venues(venue_id),
    CONSTRAINT fk_events_organizer FOREIGN KEY (organizer_id) REFERENCES organizers(organizer_id)
);

CREATE TABLE tickets (
    ticket_id INT NOT NULL,
    ticket_code VARCHAR(100),
    event_id INT,
    ticket_type VARCHAR(100),
    seat_category VARCHAR(100),
    original_price DECIMAL(12,2),
    discount_percent DECIMAL(8,2),
    final_price DECIMAL(12,2),
    ticket_status VARCHAR(100),
    PRIMARY KEY (ticket_id),
    CONSTRAINT fk_tickets_event FOREIGN KEY (event_id) REFERENCES events(event_id)
);

CREATE TABLE bookings (
    booking_id INT NOT NULL,
    booking_reference VARCHAR(100),
    customer_id INT,
    ticket_id INT,
    booking_date DATE,
    quantity INT,
    booking_channel VARCHAR(100),
    booking_status VARCHAR(100),
    PRIMARY KEY (booking_id),
    CONSTRAINT fk_bookings_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_bookings_ticket FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id)
);

CREATE TABLE payments (
    payment_id INT NOT NULL,
    transaction_id VARCHAR(100),
    booking_id INT,
    payment_date DATE,
    amount DECIMAL(14,2),
    payment_method VARCHAR(100),
    payment_status VARCHAR(100),
    refund_amount DECIMAL(14,2),
    PRIMARY KEY (payment_id),
    CONSTRAINT fk_payments_booking FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

CREATE TABLE attendance (
    attendance_id INT NOT NULL,
    event_id INT,
    customer_id INT,
    ticket_id INT,
    checkin_time DATETIME,
    checkout_time DATETIME,
    attendance_status VARCHAR(100),
    entry_gate VARCHAR(100),
    PRIMARY KEY (attendance_id),
    CONSTRAINT fk_attendance_event FOREIGN KEY (event_id) REFERENCES events(event_id),
    CONSTRAINT fk_attendance_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_attendance_ticket FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id)
);

CREATE TABLE weather (
    weather_id INT NOT NULL,
    event_id INT,
    weather_date DATE,
    temperature_c DECIMAL(8,2),
    rainfall_mm DECIMAL(10,2),
    humidity_percent DECIMAL(8,2),
    wind_speed_kmph DECIMAL(10,2),
    weather_condition VARCHAR(100),
    PRIMARY KEY (weather_id),
    CONSTRAINT fk_weather_event FOREIGN KEY (event_id) REFERENCES events(event_id)
);

-- ------------------------------------------------------------
-- CSV LOAD
-- Change /Users/ajeetkumar/Desktop/Event_Intelligence_Raw_Data/
-- if your files are in another folder.
-- ------------------------------------------------------------

LOAD DATA LOCAL INFILE '/Users/ajeetkumar/Desktop/Event_Intelligence_Raw_Data/cleaned/event_categories.csv'
INTO TABLE event_categories
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(category_id, category_code, category_name, parent_category);

LOAD DATA LOCAL INFILE '/Users/ajeetkumar/Desktop/Event_Intelligence_Raw_Data/cleaned/organizers.csv'
INTO TABLE organizers
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(organizer_id, organizer_code, organizer_name, organizer_type, city, years_in_business, contact_email);

LOAD DATA LOCAL INFILE '/Users/ajeetkumar/Desktop/Event_Intelligence_Raw_Data/cleaned/venues.csv'
INTO TABLE venues
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(venue_id, venue_code, venue_name, city, state, venue_type, capacity, indoor_outdoor, metro_distance_km, parking_capacity);

LOAD DATA LOCAL INFILE '/Users/ajeetkumar/Desktop/Event_Intelligence_Raw_Data/cleaned/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(customer_id, customer_email, customer_name, age, gender, city, state, registration_date, customer_segment);

LOAD DATA LOCAL INFILE '/Users/ajeetkumar/Desktop/Event_Intelligence_Raw_Data/cleaned/events.csv'
INTO TABLE events
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(event_id, event_code, event_name, category_id, venue_id, organizer_id, event_date, start_time, end_time, expected_attendance, base_ticket_price, event_status);

LOAD DATA LOCAL INFILE '/Users/ajeetkumar/Desktop/Event_Intelligence_Raw_Data/cleaned/tickets.csv'
INTO TABLE tickets
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ticket_id, ticket_code, event_id, ticket_type, seat_category, original_price, discount_percent, final_price, ticket_status);

LOAD DATA LOCAL INFILE '/Users/ajeetkumar/Desktop/Event_Intelligence_Raw_Data/cleaned/bookings.csv'
INTO TABLE bookings
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(booking_id, booking_reference, customer_id, ticket_id, booking_date, quantity, booking_channel, booking_status);

LOAD DATA LOCAL INFILE '/Users/ajeetkumar/Desktop/Event_Intelligence_Raw_Data/cleaned/payments.csv'
INTO TABLE payments
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(payment_id, transaction_id, booking_id, payment_date, amount, payment_method, payment_status, refund_amount);

LOAD DATA LOCAL INFILE '/Users/ajeetkumar/Desktop/Event_Intelligence_Raw_Data/cleaned/attendance.csv'
INTO TABLE attendance
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(attendance_id, event_id, customer_id, ticket_id, checkin_time, checkout_time, attendance_status, entry_gate);

LOAD DATA LOCAL INFILE '/Users/ajeetkumar/Desktop/Event_Intelligence_Raw_Data/cleaned/weather.csv'
INTO TABLE weather
FIELDS TERMINATED BY ',' ENCLOSED BY '"' ESCAPED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(weather_id, event_id, weather_date, temperature_c, rainfall_mm, humidity_percent, wind_speed_kmph, weather_condition);

SET FOREIGN_KEY_CHECKS = 1;

-- Quick verification
SELECT 'event_categories' AS table_name, COUNT(*) AS row_count FROM event_categories
UNION ALL SELECT 'organizers', COUNT(*) FROM organizers
UNION ALL SELECT 'venues', COUNT(*) FROM venues
UNION ALL SELECT 'customers', COUNT(*) FROM customers
UNION ALL SELECT 'events', COUNT(*) FROM events
UNION ALL SELECT 'tickets', COUNT(*) FROM tickets
UNION ALL SELECT 'bookings', COUNT(*) FROM bookings
UNION ALL SELECT 'payments', COUNT(*) FROM payments
UNION ALL SELECT 'attendance', COUNT(*) FROM attendance
UNION ALL SELECT 'weather', COUNT(*) FROM weather;

 -- EVENT INTELLIGENCE — SQL BUSINESS ANALYSIS
-- SECTION 1 — Customer Analysis


-- Q1. How many customers are there in total?
SELECT COUNT(*) AS total_customers
FROM customers;


-- Q2. How many customers are there in each city?


SELECT
    city,
    COUNT(*) AS customer_count
FROM customers
GROUP BY city
ORDER BY customer_count DESC; 

-- Q3. What is the distribution of customers by gender?

SELECT
    gender,
    COUNT(*) AS customer_count
FROM customers
GROUP BY gender
ORDER BY customer_count DESC;

-- Q4. What is the average age of customers?

SELECT
    ROUND(AVG(age), 2) AS average_customer_age
FROM customers;


-- Q5. How many customers belong to each age group?

SELECT
    CASE
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56+'
    END AS age_group,
    COUNT(*) AS customer_count
FROM customers
GROUP BY age_group
ORDER BY customer_count DESC;


-- SECTION 2 — Event Analysis

-- Q6. How many events are there in total?


SELECT COUNT(*) AS total_events
FROM events;


-- Q7. How many events are there in each category?

SELECT
    ec.category_name,
    COUNT(e.event_id) AS total_events
FROM events e
JOIN event_categories ec
    ON e.category_id = ec.category_id
GROUP BY ec.category_name
ORDER BY total_events DESC;


-- Q8. What is the average ticket price for each event category?

SELECT
    ec.category_name,
    ROUND(AVG(e.base_ticket_price), 2) AS avg_ticket_price
FROM events e
JOIN event_categories ec
    ON e.category_id = ec.category_id
GROUP BY ec.category_name
ORDER BY avg_ticket_price DESC;


-- Q9. What are the top 10 events by ticket price?

SELECT
    event_id,
    event_name,
    base_ticket_price
FROM events
ORDER BY base_ticket_price DESC
LIMIT 10;


-- Q10. How many events are organized by each organizer?

SELECT
    o.organizer_name,
    COUNT(e.event_id) AS total_events
FROM organizers o
LEFT JOIN events e
    ON o.organizer_id = e.organizer_id
GROUP BY o.organizer_id, o.organizer_name
ORDER BY total_events DESC;


-- SECTION 3 — Venue Analysis

-- Q11. How many events are hosted at each venue?

SELECT
    v.venue_name,
    COUNT(e.event_id) AS total_events
FROM venues v
LEFT JOIN events e
    ON v.venue_id = e.venue_id
GROUP BY v.venue_id, v.venue_name
ORDER BY total_events DESC;

-- Q12. Which venues have the highest capacity?

SELECT
    venue_id,
    venue_name,
    capacity
FROM venues
ORDER BY capacity DESC
LIMIT 10;


-- Q13. Which cities have the highest number of venues?

SELECT
    city,
    COUNT(*) AS total_venues
FROM venues
GROUP BY city
ORDER BY total_venues DESC;


-- SECTION 4 — Booking Analysis

-- Q14. How many bookings have been made in total?

SELECT COUNT(*) AS total_bookings
FROM bookings;


-- Q15. What is the distribution of bookings by booking status?

SELECT
    booking_status,
    COUNT(*) AS total_bookings
FROM bookings
GROUP BY booking_status
ORDER BY total_bookings DESC;


-- Q16. Which booking channels generate the most bookings?

SELECT
    booking_channel,
    COUNT(*) AS total_bookings,
    SUM(quantity) AS total_tickets
FROM bookings
GROUP BY booking_channel
ORDER BY total_bookings DESC;


-- Q17. What is the monthly booking trend?

SELECT
    DATE_FORMAT(booking_date, '%Y-%m') AS booking_month,
    COUNT(*) AS total_bookings,
    SUM(quantity) AS total_tickets
FROM bookings
GROUP BY DATE_FORMAT(booking_date, '%Y-%m')
ORDER BY booking_month;

-- Q18. Which customers have made the highest number of bookings?

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(b.booking_id) AS total_bookings
FROM customers c
JOIN bookings b
    ON c.customer_id = b.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_bookings DESC
LIMIT 10;

-- SECTION 5 — Ticket Analysis

-- Q19. What is the distribution of tickets by ticket type?

SELECT
    ticket_type,
    COUNT(*) AS ticket_count
FROM tickets
GROUP BY ticket_type
ORDER BY ticket_count DESC;

-- Q20. What is the average ticket price by ticket type?

SELECT
    ticket_type,
    ROUND(AVG(final_price), 2) AS avg_ticket_price
FROM tickets
GROUP BY ticket_type
ORDER BY avg_ticket_price DESC;

-- Q21. Which seat categories have the highest average price?

SELECT
    seat_category,
    COUNT(*) AS ticket_count,
    ROUND(AVG(final_price), 2) AS avg_price
FROM tickets
GROUP BY seat_category
ORDER BY avg_price DESC;

-- Q22. What is the average discount offered on tickets?

SELECT
    ROUND(AVG(discount_percent), 2) AS average_discount
FROM tickets;

-- Q23. What are the top 10 tickets with the highest discount?

SELECT
    ticket_id,
    ticket_type,
    seat_category,
    discount_percent,
    original_price,
    final_price
FROM tickets
ORDER BY discount_percent DESC
LIMIT 10;

-- SECTION 6 — Revenue & Payment Analysis

-- Q24. What is the total revenue generated from completed payments?

SELECT
    ROUND(SUM(amount), 2) AS total_revenue
FROM payments
WHERE payment_status = 'Completed';

-- Q25. What is the distribution of payments by payment status?

SELECT
    payment_status,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount), 2) AS total_amount
FROM payments
GROUP BY payment_status
ORDER BY total_amount DESC;

-- Q26. Which payment methods generate the highest revenue?

SELECT
    payment_method,
    COUNT(*) AS transactions,
    ROUND(SUM(amount), 2) AS total_revenue
FROM payments
WHERE payment_status = 'Completed'
GROUP BY payment_method
ORDER BY total_revenue DESC;

-- Q27. What is the monthly revenue trend?

SELECT
    DATE_FORMAT(payment_date, '%Y-%m') AS payment_month,
    ROUND(SUM(amount), 2) AS monthly_revenue
FROM payments
WHERE payment_status = 'Completed'
GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY payment_month;

-- Q28. What are the top 10 events by revenue?

SELECT
    e.event_id,
    e.event_name,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM payments p
JOIN bookings b
    ON p.booking_id = b.booking_id
JOIN tickets t
    ON b.ticket_id = t.ticket_id
JOIN events e
    ON t.event_id = e.event_id
WHERE p.payment_status = 'Completed'
GROUP BY e.event_id, e.event_name
ORDER BY total_revenue DESC
LIMIT 10;

-- SECTION 7 — Category Performance

-- Q29. Which event categories generate the highest revenue?

SELECT
    ec.category_name,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM payments p
JOIN bookings b
    ON p.booking_id = b.booking_id
JOIN tickets t
    ON b.ticket_id = t.ticket_id
JOIN events e
    ON t.event_id = e.event_id
JOIN event_categories ec
    ON e.category_id = ec.category_id
WHERE p.payment_status = 'Completed'
GROUP BY ec.category_name
ORDER BY total_revenue DESC;


-- Q30. What percentage of total revenue comes from each event category?
W
ITH category_revenue AS (
    SELECT
        ec.category_name,
        SUM(p.amount) AS revenue
    FROM payments p
    JOIN bookings b
        ON p.booking_id = b.booking_id
    JOIN tickets t
        ON b.ticket_id = t.ticket_id
    JOIN events e
        ON t.event_id = e.event_id
    JOIN event_categories ec
        ON e.category_id = ec.category_id
    WHERE p.payment_status = 'Completed'
    GROUP BY ec.category_name
)

SELECT
    category_name,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        revenue * 100.0 / SUM(revenue) OVER (),
        2
    ) AS revenue_percentage
FROM category_revenue
ORDER BY revenue DESC;


-- SECTION 8 — Customer Behaviour

-- Q31. Which customers have made more than one booking?

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(b.booking_id) AS total_bookings
FROM customers c
JOIN bookings b
    ON c.customer_id = b.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(b.booking_id) > 1
ORDER BY total_bookings DESC;


-- Q32. Which customer segments generate the most bookings?
SELECT
    c.customer_segment,
    COUNT(b.booking_id) AS total_bookings,
    SUM(b.quantity) AS total_tickets
FROM customers c
JOIN bookings b
    ON c.customer_id = b.customer_id
GROUP BY c.customer_segment
ORDER BY total_bookings DESC;

-- Q33. Which customer segments generate the highest revenue?

SELECT
    c.customer_segment,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM customers c
JOIN bookings b
    ON c.customer_id = b.customer_id
JOIN payments p
    ON b.booking_id = p.booking_id
WHERE p.payment_status = 'Completed'
GROUP BY c.customer_segment
ORDER BY total_revenue DESC;

-- Q34. Which age groups generate the most bookings?
S
ELECT
    CASE
        WHEN c.age BETWEEN 18 AND 25 THEN '18-25'
        WHEN c.age BETWEEN 26 AND 35 THEN '26-35'
        WHEN c.age BETWEEN 36 AND 45 THEN '36-45'
        WHEN c.age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56+'
    END AS age_group,
    COUNT(b.booking_id) AS total_bookings
FROM customers c
JOIN bookings b
    ON c.customer_id = b.customer_id
GROUP BY age_group
ORDER BY total_bookings DESC;

-- SECTION 9 — Attendance Analysis

-- Q35. What is the distribution of attendance status?

SELECT
    attendance_status,
    COUNT(*) AS attendance_count
FROM attendance
GROUP BY attendance_status
ORDER BY attendance_count DESC;

-- Q36. Which events have the highest attendance?

SELECT
    e.event_id,
    e.event_name,
    COUNT(a.attendance_id) AS attendance_count
FROM attendance a
JOIN events e
    ON a.event_id = e.event_id
GROUP BY e.event_id, e.event_name
ORDER BY attendance_count DESC
LIMIT 10;

-- Q37. What is the attendance rate for each event?
SELECT
    e.event_id,
    e.event_name,
    e.expected_attendance,
    COUNT(a.attendance_id) AS actual_attendance,
    ROUND(
        COUNT(a.attendance_id) * 100.0 /
        NULLIF(e.expected_attendance, 0),
        2
    ) AS attendance_rate
FROM events e
LEFT JOIN attendance a
    ON e.event_id = a.event_id
GROUP BY
    e.event_id,
    e.event_name,
    e.expected_attendance
ORDER BY attendance_rate DESC;

-- SECTION 10 — Organizer Analysis

-- Q38. Which organizers generate the highest revenue?
SELECT
    o.organizer_id,
    o.organizer_name,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM organizers o
JOIN events e
    ON o.organizer_id = e.organizer_id
JOIN tickets t
    ON e.event_id = t.event_id
JOIN bookings b
    ON t.ticket_id = b.ticket_id
JOIN payments p
    ON b.booking_id = p.booking_id
WHERE p.payment_status = 'Completed'
GROUP BY o.organizer_id, o.organizer_name
ORDER BY total_revenue DESC;

-- Q39. Which organizers have the highest number of bookings?
SELECT
    o.organizer_name,
    COUNT(b.booking_id) AS total_bookings
FROM organizers o
JOIN events e
    ON o.organizer_id = e.organizer_id
JOIN tickets t
    ON e.event_id = t.event_id
JOIN bookings b
    ON t.ticket_id = b.ticket_id
GROUP BY o.organizer_id, o.organizer_name
ORDER BY total_bookings DESC;

-- - SECTION 11 — Advanced SQL / Window Functions
-- Q40. Rank event categories based on revenue.

wITH category_revenue AS (
    SELECT
        ec.category_name,
        SUM(p.amount) AS revenue
    FROM payments p
    JOIN bookings b
        ON p.booking_id = b.booking_id
    JOIN tickets t
        ON b.ticket_id = t.ticket_id
    JOIN events e
        ON t.event_id = e.event_id
    JOIN event_categories ec
        ON e.category_id = ec.category_id
    WHERE p.payment_status = 'Completed'
    GROUP BY ec.category_name
)

SELECT
    category_name,
    ROUND(revenue, 2) AS revenue,
    DENSE_RANK() OVER (
        ORDER BY revenue DESC
    ) AS revenue_rank
FROM category_revenue;

-- Q41. What are the top 3 revenue-generating events within each category?
WITH event_revenue AS (
    SELECT
        ec.category_name,
        e.event_id,
        e.event_name,
        SUM(p.amount) AS revenue
    FROM payments p
    JOIN bookings b
        ON p.booking_id = b.booking_id
    JOIN tickets t
        ON b.ticket_id = t.ticket_id
    JOIN events e
        ON t.event_id = e.event_id
    JOIN event_categories ec
        ON e.category_id = ec.category_id
    WHERE p.payment_status = 'Completed'
    GROUP BY
        ec.category_name,
        e.event_id,
        e.event_name
),

ranked_events AS (
    SELECT
        *,
        DENSE_RANK() OVER (
            PARTITION BY category_name
            ORDER BY revenue DESC
        ) AS event_rank
    FROM event_revenue
)

SELECT
    category_name,
    event_name,
    ROUND(revenue, 2) AS revenue,
    event_rank
FROM ranked_events
WHERE event_rank <= 3
ORDER BY category_name, event_rank;

-- Q42. What is the monthly revenue and its running total?

WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(payment_date, '%Y-%m') AS month,
        SUM(amount) AS revenue
    FROM payments
    WHERE payment_status = 'Completed'
    GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
)

SELECT
    month,
    ROUND(revenue, 2) AS monthly_revenue,
    ROUND(
        SUM(revenue) OVER (
            ORDER BY month
        ),
        2
    ) AS running_revenue
FROM monthly_revenue
ORDER BY month;

-- - SECTION 12 — Final Business Questions

-- Q43. Which events have high bookings but low attendance?

SELECT
    e.event_id,
    e.event_name,
    COUNT(DISTINCT b.booking_id) AS total_bookings,
    COUNT(DISTINCT a.attendance_id) AS total_attendance
FROM events e
LEFT JOIN tickets t
    ON e.event_id = t.event_id
LEFT JOIN bookings b
    ON t.ticket_id = b.ticket_id
LEFT JOIN attendance a
    ON e.event_id = a.event_id
GROUP BY e.event_id, e.event_name
HAVING total_bookings > 0
ORDER BY total_bookings DESC, total_attendance ASC;

-- Q44. Which venues generate the highest revenue?
SELECT
    v.venue_name,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM venues v
JOIN events e
    ON v.venue_id = e.venue_id
JOIN tickets t
    ON e.event_id = t.event_id
JOIN bookings b
    ON t.ticket_id = b.ticket_id
JOIN payments p
    ON b.booking_id = p.booking_id
WHERE p.payment_status = 'Completed'
GROUP BY v.venue_id, v.venue_name
ORDER BY total_revenue DESC;

-- Q45. What is the average revenue generated per booking?

SELECT
    ROUND(
        SUM(p.amount) / COUNT(DISTINCT b.booking_id),
        2
    ) AS average_revenue_per_booking
FROM payments p
JOIN bookings b
    ON p.booking_id = b.booking_id
WHERE p.payment_status = 'Completed';

-- Q46. Which events have generated the highest number of bookings?

SELECT
    e.event_id,
    e.event_name,
    COUNT(b.booking_id) AS total_bookings
FROM events e
JOIN tickets t
    ON e.event_id = t.event_id
JOIN bookings b
    ON t.ticket_id = b.ticket_id
GROUP BY e.event_id, e.event_name
ORDER BY total_bookings DESC
LIMIT 10;

-- Q47. Which event categories have the highest number of bookings?

SELECT
    ec.category_name,
    COUNT(b.booking_id) AS total_bookings
FROM event_categories ec
JOIN events e
    ON ec.category_id = e.category_id
JOIN tickets t
    ON e.event_id = t.event_id
JOIN bookings b
    ON t.ticket_id = b.ticket_id
GROUP BY ec.category_name
ORDER BY total_bookings DESC;

-- Q48. Which customers have generated the highest revenue?

SELECT
    c.customer_id,
    c.customer_name,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM customers c
JOIN bookings b
    ON c.customer_id = b.customer_id
JOIN payments p
    ON b.booking_id = p.booking_id
WHERE p.payment_status = 'Completed'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Q49. What is the overall booking-to-attendance conversion rate?

SELECT
    ROUND(
        COUNT(DISTINCT a.attendance_id) * 100.0 /
        NULLIF(COUNT(DISTINCT b.booking_id), 0),
        2
    ) AS attendance_conversion_rate
FROM bookings b
LEFT JOIN tickets t
    ON b.ticket_id = t.ticket_id
LEFT JOIN attendance a
    ON t.event_id = a.event_id;

-- Q50. What are the overall key business metrics?
SELECT
    (SELECT COUNT(*) FROM customers) AS total_customers,

    (SELECT COUNT(*) FROM events) AS total_events,

    (SELECT COUNT(*) FROM bookings) AS total_bookings,

    (SELECT COUNT(*) FROM tickets) AS total_tickets,

    (SELECT ROUND(SUM(amount), 2)
     FROM payments
     WHERE payment_status = 'Completed') AS total_revenue,

    (SELECT COUNT(*) FROM attendance) AS total_attendance;
