

-- Sample Data for User Table
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
(1, 'Alice', 'Smith', 'alice.smith@example.com', 'hashed_password_1', '111-222-3333', 'guest', '2024-01-15 10:00:00'),
(2, 'Bob', 'Johnson', 'bob.johnson@example.com', 'hashed_password_2', '444-555-6666', 'host', '2024-01-20 11:30:00'),
(3, 'Charlie', 'Brown', 'charlie.brown@example.com', 'hashed_password_3', '777-888-9999', 'admin', '2024-01-25 14:00:00'),
(4, 'Diana', 'Prince', 'diana.p@example.com', 'hashed_password_4', '000-111-2222', 'guest', '2024-02-01 09:15:00'),
(5, 'Eve', 'Adams', 'eve.adams@example.com', 'hashed_password_5', '333-444-5555', 'host', '2024-02-05 16:45:00');

-- Sample Data for Property Table
-- Use pre-defined UUIDs or generate them for each insert
INSERT INTO Property (property_id, host_id, name, description, location, price_per_night, created_at, updated_at) VALUES
('b2c1d9e8-7f6a-4b5c-8d0a-1e2f3g4h5i6j', 2, 'Cozy Apartment', 'A charming apartment in the heart of the city.', 'Downtown', 120.00, '2024-03-01 09:00:00', '2024-03-01 09:00:00'),
('a1b2c3d4-e5f6-7g8h-9i0j-k1l2m3n4o5p6', 2, 'Spacious Villa', 'Luxurious villa with a private pool and garden.', 'Suburbs', 350.00, '2024-03-10 10:30:00', '2024-03-10 10:30:00'),
('c7d6e5f4-a3b2-1c0d-e9f8-7g6h5i4j3k2l', 5, 'Beachfront Bungalow', 'Relaxing bungalow with direct access to the beach.', 'Coastal Area', 200.00, '2024-03-15 11:00:00', '2024-03-15 11:00:00'),
('d8e7f6g5-h4i3-j2k1-l0m9-n8o7p6q5r4s3', 5, 'Mountain Cabin', 'Secluded cabin perfect for a peaceful getaway.', 'Mountain Region', 150.00, '2024-03-20 14:00:00', '2024-03-20 14:00:00');

-- Sample Data for Booking Table
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
('f1e2d3c4-b5a6-9b8c-7d6e-5f4a3b2c1d0e', 'b2c1d9e8-7f6a-4b5c-8d0a-1e2f3g4h5i6j', 1, '2024-07-01', '2024-07-07', 840.00, 'confirmed', '2024-05-01 10:00:00'),
('g2h3i4j5-k6l7-8m9n-0o1p-2q3r4s5t6u7v', 'a1b2c3d4-e5f6-7g8h-9i0j-k1l2m3n4o5p6', 4, '2024-08-10', '2024-08-15', 1750.00, 'pending', '2024-05-15 11:30:00'),
('h3i4j5k6-l7m8-9n0o-1p2q-3r4s5t6u7v8w', 'c7d6e5f4-a3b2-1c0d-e9f8-7g6h5i4j3k2l', 1, '2024-09-01', '2024-09-05', 800.00, 'confirmed', '2024-06-01 14:00:00'),
('i4j5k6l7-m8n9-0o1p-2q3r-4s5t6u7v8w9x', 'b2c1d9e8-7f6a-4b5c-8d0a-1e2f3g4h5i6j', 4, '2024-09-10', '2024-09-12', 240.00, 'canceled', '2024-06-05 16:00:00');

-- Sample Data for Payment Table
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
('0a1b2c3d-4e5f-6a7b-8c9d-0e1f2a3b4c5d', 'f1e2d3c4-b5a6-9b8c-7d6e-5f4a3b2c1d0e', 840.00, '2024-05-01 10:15:00', 'credit_card'),
('1b2c3d4e-5f6a-7b8c-9d0e-1f2a3b4c5d6e', 'g2h3i4j5-k6l7-8m9n-0o1p-2q3r4s5t6u7v', 1750.00, '2024-05-15 11:45:00', 'paypal'),
('2c3d4e5f-6a7b-8c9d-0e1f-2a3b4c5d6e7f', 'h3i4j5k6-l7m8-9n0o-1p2q-3r4s5t6u7v8w', 800.00, '2024-06-01 14:10:00', 'stripe');

-- Sample Data for Review Table
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
('3d4e5f6a-7b8c-9d0e-1f2a-3b4c5d6e7f8a', 'b2c1d9e8-7f6a-4b5c-8d0a-1e2f3g4h5i6j', 1, 5, 'Wonderful stay! Highly recommend this cozy apartment.', '2024-07-08 09:00:00'),
('4e5f6a7b-8c9d-0e1f-2a3b-4c5d6e7f8a9b', 'a1b2c3d4-e5f6-7g8h-9i0j-k1l2m3n4o5p6', 4, 4, 'Beautiful villa, though a bit far from the city center.', '2024-08-16 10:30:00'),
('5f6a7b8c-9d0e-1f2a-3b4c-5d6e7f8a9b0c', 'c7d6e5f4-a3b2-1c0d-e9f8-7g6h5i4j3k2l', 1, 5, 'Perfect beachfront location, enjoyed every moment!', '2024-09-06 11:00:00');

-- Sample Data for Message Table
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
('6a7b8c9d-0e1f-2a3b-4c5d-6e7f8a9b0c1d', 1, 2, 'Hi Bob, I am looking forward to my stay at your apartment.', '2024-06-20 09:00:00'),
('7b8c9d0e-1f2a-3b4c-5d6e-7f8a9b0c1d2e', 2, 1, 'Great, Alice! Let me know if you have any questions.', '2024-06-20 09:05:00'),
('8c9d0e1f-2a3b-4c5d-6e7f-8a9b0c1d2e3f', 4, 5, 'Hello Eve, is the mountain cabin available for October?', '2024-06-25 14:00:00'),
('9d0e1f2a-3b4c-5d6e-7f8a-9b0c1d2e3f4g', 5, 4, 'Hi Diana, yes, it is. What dates are you considering?', '2024-06-25 14:10:00');

