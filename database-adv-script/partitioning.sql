-- Objective: Implement table partitioning to optimize queries on large datasets.
-- This script assumes a PostgreSQL-like syntax for partitioning.
-- Syntax may vary slightly for other database systems (e.g., MySQL, SQL Server, Oracle).

-- Step 1: Create the partitioned table.
-- First, rename the original Bookings table if it exists and contains data you want to migrate.
-- Or, if starting fresh, just create the new partitioned table.

-- Example for PostgreSQL:
-- If you have an existing Bookings table with data, you might want to rename it first:
-- ALTER TABLE Bookings RENAME TO Bookings_old;

-- Create the new partitioned Bookings table.
-- We will partition by RANGE on the 'start_date' column.
CREATE TABLE Bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (property_id) REFERENCES Properties(property_id)
) PARTITION BY RANGE (start_date);

-- Step 2: Create partitions for specific date ranges.
-- It's common to partition by year or by quarter, depending on data volume and query patterns.
-- Here, we'll create yearly partitions for a few years as an example.

-- Partition for 2023 bookings
CREATE TABLE Bookings_2023 PARTITION OF Bookings
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

-- Partition for 2024 bookings
CREATE TABLE Bookings_2024 PARTITION OF Bookings
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- Partition for 2025 bookings (relevant to the WHERE clause in performance.sql)
CREATE TABLE Bookings_2025 PARTITION OF Bookings
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- You can add more partitions as needed for future years or historical data.
-- CREATE TABLE Bookings_2026 PARTITION OF Bookings FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');

-- Step 3: Migrate existing data (if you renamed the old table).
-- If you renamed Bookings_old, you would insert its data into the new partitioned table.
-- The database system will automatically route the rows to the correct partition.
-- INSERT INTO Bookings SELECT * FROM Bookings_old;

-- Step 4: Add indexes to the partitioned table (and its partitions).
-- Indexes on the partitioning key are often automatically handled by the DBMS,
-- but other frequently queried columns should still be indexed.
-- These indexes will apply to all partitions.
CREATE INDEX idx_bookings_user_id ON Bookings (user_id);
CREATE INDEX idx_bookings_property_id ON Bookings (property_id);
-- The primary key (booking_id) is automatically indexed.

-- Test the performance of queries on the partitioned table.
-- The key benefit of partitioning is "partition pruning" where the database
-- only scans relevant partitions for queries that filter on the partitioning key.

-- Example Query (similar to the one in performance.sql, but now benefiting from partitioning):
-- This query will only scan the 'Bookings_2025' partition.
SELECT
    B.booking_id,
    B.start_date,
    B.end_date,
    B.total_price,
    U.user_name,
    U.user_email,
    P.property_name,
    P.property_address,
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
    Payments PM ON B.booking_id = PM.booking_id
WHERE
    B.start_date >= '2025-01-01' AND B.end_date <= '2025-12-31';

-- To test performance, use EXPLAIN ANALYZE (or similar command for your DBMS)
-- before and after implementing partitioning.

-- EXPLAIN ANALYZE
-- SELECT ... FROM Bookings B JOIN ... WHERE B.start_date >= '2025-01-01' AND B.end_date <= '2025-12-31';

-- Brief Report on Observed Improvements (Hypothetical):
-- After implementing table partitioning on the 'Bookings' table based on 'start_date',
-- significant performance improvements were observed for queries filtering by date ranges.
--
-- 1. Reduced Scan Scope: Queries like "fetching bookings by date range" (e.g., for '2025')
--    now only scan the relevant 'Bookings_2025' partition, rather than the entire 'Bookings' table.
--    This dramatically reduces the amount of data the database needs to read and process.
--
-- 2. Faster Query Execution: The execution time for date-range queries decreased by [e.g., 50-80%],
--    especially noticeable on very large datasets. The `EXPLAIN ANALYZE` output clearly showed
--    "Partition Pruning" in action, indicating that only the necessary partitions were accessed.
--
-- 3. Improved Index Efficiency: While indexes were already beneficial, partitioning further
--    enhances their effectiveness by reducing the size of the data set over which the index
--    needs to operate for specific queries.
--
-- 4. Easier Maintenance: Although not directly a query performance metric, partitioning also
--    simplifies maintenance tasks like archiving old data or rebuilding indexes, as these
--    operations can be performed on individual partitions rather than the entire table.













-- Objective: Implement table partitioning to optimize queries on large datasets.
-- This script assumes a PostgreSQL-like syntax for partitioning.
-- Syntax may vary slightly for other database systems (e.g., MySQL, SQL Server, Oracle).

-- Step 1: Create the partitioned table.
-- First, rename the original Bookings table if it exists and contains data you want to migrate.
-- Or, if starting fresh, just create the new partitioned table.

-- Example for PostgreSQL:
-- If you have an existing Bookings table with data, you might want to rename it first:
-- ALTER TABLE Bookings RENAME TO Bookings_old;

-- Create the new partitioned Bookings table.
-- We will partition by RANGE on the 'start_date' column.
CREATE TABLE Bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    property_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (property_id) REFERENCES Properties(property_id)
) PARTITION BY RANGE (start_date);

-- Step 2: Create partitions for specific date ranges.
-- It's common to partition by year or by quarter, depending on data volume and query patterns.
-- Here, we'll create yearly partitions for a few years as an example.

-- Partition for 2023 bookings
CREATE TABLE Bookings_2023 PARTITION OF Bookings
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

-- Partition for 2024 bookings
CREATE TABLE Bookings_2024 PARTITION OF Bookings
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

-- Partition for 2025 bookings (relevant to the WHERE clause in performance.sql)
CREATE TABLE Bookings_2025 PARTITION OF Bookings
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- You can add more partitions as needed for future years or historical data.
-- CREATE TABLE Bookings_2026 PARTITION OF Bookings FOR VALUES FROM ('2026-01-01') TO ('2027-01-01');

-- Step 3: Migrate existing data (if you renamed the old table).
-- If you renamed Bookings_old, you would insert its data into the new partitioned table.
-- The database system will automatically route the rows to the correct partition.
-- INSERT INTO Bookings SELECT * FROM Bookings_old;

-- Step 4: Add indexes to the partitioned table (and its partitions).
-- Indexes on the partitioning key are often automatically handled by the DBMS,
-- but other frequently queried columns should still be indexed.
-- These indexes will apply to all partitions.
CREATE INDEX idx_bookings_user_id ON Bookings (user_id);
CREATE INDEX idx_bookings_property_id ON Bookings (property_id);
-- The primary key (booking_id) is automatically indexed.

-- Test the performance of queries on the partitioned table.
-- The key benefit of partitioning is "partition pruning" where the database
-- only scans relevant partitions for queries that filter on the partitioning key.

-- Example Query (similar to the one in performance.sql, but now benefiting from partitioning):
-- This query will only scan the 'Bookings_2025' partition.
SELECT
    B.booking_id,
    B.start_date,
    B.end_date,
    B.total_price,
    U.user_name,
    U.user_email,
    P.property_name,
    P.property_address,
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
    Payments PM ON B.booking_id = PM.booking_id
WHERE
    B.start_date >= '2025-01-01' AND B.end_date <= '2025-12-31';

-- To test performance, use EXPLAIN ANALYZE (or similar command for your DBMS)
-- before and after implementing partitioning.

-- EXPLAIN ANALYZE
-- SELECT ... FROM Bookings B JOIN ... WHERE B.start_date >= '2025-01-01' AND B.end_date <= '2025-12-31';

-- Brief Report on Observed Improvements (Hypothetical):
-- After implementing table partitioning on the 'Bookings' table based on 'start_date',
-- significant performance improvements were observed for queries filtering by date ranges.
--
-- 1. Reduced Scan Scope: Queries like "fetching bookings by date range" (e.g., for '2025')
--    now only scan the relevant 'Bookings_2025' partition, rather than the entire 'Bookings' table.
--    This dramatically reduces the amount of data the database needs to read and process.
--
-- 2. Faster Query Execution: The execution time for date-range queries decreased by [e.g., 50-80%],
--    especially noticeable on very large datasets. The `EXPLAIN ANALYZE` output clearly showed
--    "Partition Pruning" in action, indicating that only the necessary partitions were accessed.
--
-- 3. Improved Index Efficiency: While indexes were already beneficial, partitioning further
--    enhances their effectiveness by reducing the size of the data set over which the index
--    needs to operate for specific queries.
--
-- 4. Easier Maintenance: Although not directly a query performance metric, partitioning also
--    simplifies maintenance tasks like archiving old data or rebuilding indexes, as these
--    operations can be performed on individual partitions rather than the entire table.


-- Objective: Continuously monitor and refine database performance by analyzing query execution plans and making schema adjustments.

-- Step 5: Monitor Query Performance
-- Use SQL commands to analyze the execution plans of frequently used queries.
-- This helps identify bottlenecks such as full table scans, inefficient joins, or excessive sorting.

-- For PostgreSQL:
-- EXPLAIN ANALYZE SELECT B.booking_id, U.user_name, P.property_name FROM Bookings B JOIN Users U ON B.user_id = U.user_id JOIN Properties P ON B.property_id = P.property_id WHERE B.start_date = '2025-07-01';

-- For MySQL:
-- SHOW PROFILE FOR QUERY 1; -- After running a query, you can use SHOW PROFILE to see detailed execution steps.
-- EXPLAIN SELECT B.booking_id, U.user_name, P.property_name FROM Bookings B JOIN Users U ON B.user_id = U.user_id JOIN Properties P ON B.property_id = P.property_id WHERE B.start_date = '2025-07-01';

-- Step 6: Identify Bottlenecks and Suggest Changes
-- Based on the EXPLAIN ANALYZE output, look for:
-- - High costs for sequential scans on large tables.
-- - Missing indexes on columns used in WHERE, JOIN, or ORDER BY clauses.
-- - Inefficient join types (e.g., nested loops on large datasets without indexes).
-- - Excessive sorting or temporary file usage.

-- Example Bottleneck: A query filtering by 'end_date' might be slow if no index exists.
-- Suggested Change: Add an index on `end_date` in the `Bookings` table.
-- CREATE INDEX idx_bookings_end_date ON Bookings (end_date);

-- Example Bottleneck: A query joining `Bookings` and `Payments` is slow due to `payment_status` filtering.
-- Suggested Change: Add a composite index if `payment_status` is often used with `booking_id`.
-- CREATE INDEX idx_payments_booking_id_status ON Payments (booking_id, payment_status);

-- Step 7: Implement Changes and Report Improvements (Hypothetical)
-- After identifying bottlenecks and implementing suggested changes (like adding new indexes or adjusting schema),
-- re-run the `EXPLAIN ANALYZE` command for the affected queries.

-- Report on Improvements:
-- 1. Query: Fetching bookings by specific `end_date`.
--    - Initial Performance: High cost, sequential scan on `Bookings` table.
--    - Change Implemented: Added `CREATE INDEX idx_bookings_end_date ON Bookings (end_date);`
--    - Observed Improvement: Query execution time reduced by [e.g., 30-60%]. `EXPLAIN ANALYZE` now shows "Index Scan" instead of "Sequential Scan" on the `Bookings` table for `end_date` filters.

-- 2. Query: Retrieving payment details for bookings with a specific status.
--    - Initial Performance: Nested loop join with high cost due to filtering `payment_status` without a suitable index.
--    - Change Implemented: Added `CREATE INDEX idx_payments_booking_id_status ON Payments (booking_id, payment_status);`
--    - Observed Improvement: Join operation became more efficient, reducing overall query time by [e.g., 20-40%]. The composite index allowed for faster lookup and filtering.

-- Continuous monitoring and iterative refinement of indexes and schema are crucial for maintaining optimal database performance as data grows and query patterns evolve.
