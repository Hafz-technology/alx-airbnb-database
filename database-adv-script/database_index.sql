CREATE INDEX idx_ratings_property_id_rating ON Ratings (property_id, rating);



CREATE INDEX idx_bookings_user_id ON Bookings (user_id);

CREATE INDEX idx_bookings_property_id ON Bookings (property_id);

