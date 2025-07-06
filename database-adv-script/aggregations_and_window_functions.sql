/* Write a query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.  */

SELECT
    user_id,
    COUNT(booking_id) AS total_bookings
FROM
    Bookings
GROUP BY
    user_id
ORDER BY
    total_bookings DESC;



/*  Use a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received. */ 

SELECT
    property_id,
    total_bookings,
    RANK() OVER (ORDER BY total_bookings DESC) AS booking_rank
FROM (
    SELECT
        property_id,
        COUNT(booking_id) AS total_bookings
    FROM
        Bookings
    GROUP BY
        property_id
) AS PropertyBookings;

