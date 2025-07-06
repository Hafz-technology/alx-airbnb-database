
/*  Query 1    */

SELECT
    b.booking_id,
    b.start_date,
    b.end_date,
    u.first_name,
    u.last_name,
    u.email
FROM
    Booking AS b
INNER JOIN
    "User" AS u ON b.user_id = u.user_id
ORDER BY
    b.booking_id; -- Added for consistent ordering



/*  Query 2    */



SELECT
    p.property_id,
    p.name AS property_name,
    r.review_id,
    r.rating,
    r.comment
FROM
    Property AS p
LEFT JOIN
    Review AS r ON p.property_id = r.property_id
ORDER BY
    p.property_id, r.review_id; -- Added for consistent ordering


/*  Query 3    */



SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.start_date,
    b.status
FROM
    "User" AS u
FULL OUTER JOIN
    Booking AS b ON u.user_id = b.user_id
ORDER BY
    u.user_id, b.booking_id; -- Added for consistent ordering


