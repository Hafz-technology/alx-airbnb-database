-- Objective: Refactor complex queries to improve performance.

-- Initial Query: Retrieve all bookings along with user details, property details, and payment details.
-- This query uses multiple JOIN operations to combine data from four tables.
SELECT
    B.booking_id,
    B.start_date,
    B.end_date,
    B.total_price,
    U.user_id,
    U.user_name,
    U.user_email,
    P.property_id,
    P.property_name,
    P.property_address,
    PM.payment_id,
    PM.amount,
    PM.payment_date,
    PM.payment_status
FROM
    Bookings B
JOIN
    Users U ON B.user_id = U.user_id
JOIN
    Properties P ON B.property_id = P.property_id
JOIN
    Payments PM ON B.booking_id = PM.booking_id;
    -- Assuming a direct link between Bookings and Payments via booking_id.
    -- If Payments links via a separate payment_id in Bookings, adjust the JOIN condition accordingly.


-- Analyze the query’s performance using EXPLAIN (or EXPLAIN ANALYZE for execution details).
-- To analyze, run the following command in your SQL client before and after adding indexes:
-- EXPLAIN ANALYZE
-- SELECT
--     B.booking_id,
--     B.start_date,
--     B.end_date,
--     B.total_price,
--     U.user_id,
--     U.user_name,
--     U.user_email,
--     P.property_id,
--     P.property_name,
--     P.property_address,
--     PM.payment_id,
--     PM.amount,
--     PM.payment_date,
--     PM.payment_status
-- FROM
--     Bookings B
-- JOIN
--     Users U ON B.user_id = U.user_id
-- JOIN
--     Properties P ON B.property_id = P.property_id
-- JOIN
--     Payments PM ON B.booking_id = PM.booking_id;

-- Common inefficiencies identified by EXPLAIN:
-- 1. Full table scans: If no appropriate indexes are used on JOIN columns, the database might scan entire tables.
-- 2. Nested loop joins on large tables without indexes: Can be very slow.
-- 3. Temporary files/sorts: If ORDER BY or GROUP BY clauses are used without suitable indexes.
-- 4. High cost for specific operations: Look for high "cost" values in the EXPLAIN output.

-- Refactored Query: Reduce execution time by leveraging indexes and specifying columns.
-- This version explicitly selects only the necessary columns, which can slightly reduce
-- network traffic and memory usage, though the primary performance gain comes from indexing.
-- The key to performance here is ensuring appropriate indexes are in place.

-- Recommended Indexes for this query (based on common JOIN patterns):
-- (These CREATE INDEX statements are also present in 'database_index.sql' and are crucial for performance)
-- CREATE INDEX idx_bookings_user_id ON Bookings (user_id);
-- CREATE INDEX idx_bookings_property_id ON Bookings (property_id);
-- CREATE INDEX idx_payments_booking_id ON Payments (booking_id); -- Important if not already a primary key or indexed.

SELECT
    B.booking_id,
    B.start_date,
    B.end_date,
    B.total_price,
    U.user_name,        -- Only specific user columns needed
    U.user_email,
    P.property_name,    -- Only specific property columns needed
    P.property_address,
    PM.amount,          -- Only specific payment columns needed
    PM.payment_date,
    PM.payment_status
FROM
    Bookings B
JOIN
    Users U ON B.user_id = U.user_id       -- Benefits from index on Bookings.user_id and Users.user_id (PK)
JOIN
    Properties P ON B.property_id = P.property_id -- Benefits from index on Bookings.property_id and Properties.property_id (PK)
JOIN
    Payments PM ON B.booking_id = PM.booking_id; -- Benefits from index on Payments.booking_id and Bookings.booking_id (PK)

-- Note on performance: The most significant performance improvements for JOIN-heavy queries
-- come from ensuring that the columns used in JOIN conditions (e.g., B.user_id, U.user_id,
-- B.property_id, P.property_id, B.booking_id, PM.booking_id) are indexed. Primary keys are
-- automatically indexed, but foreign keys often need explicit indexes.