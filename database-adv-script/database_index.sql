CREATE INDEX idx_ratings_property_id_rating ON Ratings (property_id, rating);



CREATE INDEX idx_bookings_user_id ON Bookings (user_id);

CREATE INDEX idx_bookings_property_id ON Bookings (property_id);


/*  -- Before adding indexes:
-- EXPLAIN ANALYZE SELECT p.property_id, p.property_name FROM Properties p WHERE p.property_id IN (SELECT r.property_id FROM Ratings r GROUP BY r.property_id HAVING AVG(r.rating) > 4.0);
-- EXPLAIN ANALYZE SELECT u.user_id, u.user_name FROM Users u WHERE (SELECT COUNT(b.booking_id) FROM Bookings b WHERE b.user_id = u.user_id) > 3;
-- EXPLAIN ANALYZE SELECT user_id, COUNT(booking_id) AS total_bookings FROM Bookings GROUP BY user_id ORDER BY total_bookings DESC;
-- EXPLAIN ANALYZE SELECT property_id, total_bookings, ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS booking_rank FROM (SELECT property_id, COUNT(booking_id) AS total_bookings FROM Bookings GROUP BY property_id) AS PropertyBookings;

-- After adding indexes (run the CREATE INDEX commands first, then re-run EXPLAIN ANALYZE):
-- EXPLAIN ANALYZE SELECT p.property_id, p.property_name FROM Properties p WHERE p.property_id IN (SELECT r.property_id FROM Ratings r GROUP BY r.property_id HAVING AVG(r.rating) > 4.0);
-- EXPLAIN ANALYZE SELECT u.user_id, u.user_name FROM Users u WHERE (SELECT COUNT(b.booking_id) FROM Bookings b WHERE b.user_id = u.user_id) > 3;
-- EXPLAIN ANALYZE SELECT user_id, COUNT(booking_id) AS total_bookings FROM Bookings GROUP BY user_id ORDER BY total_bookings DESC;
-- EXPLAIN ANALYZE SELECT property_id, total_bookings, ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS booking_rank FROM (SELECT property_id, COUNT(booking_id) AS total_bookings FROM Bookings GROUP BY property_id) AS PropertyBookings;

*/ 
