# Entities and Attributes
## User
* user_id: Primary Key, UUID, Indexed
* first_name: VARCHAR, NOT NULL
* last_name: VARCHAR, NOT NULL
* email: VARCHAR, UNIQUE, NOT NULL
* password_hash: VARCHAR, NOT NULL
* phone_number: VARCHAR, NULL
* role: ENUM (guest, host, admin), NOT NULL
* created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
## Property
* property_id: Primary Key, UUID, Indexed
* host_id: Foreign Key, references User(user_id)
* name: VARCHAR, NOT NULL
* description: TEXT, NOT NULL
* location: VARCHAR, NOT NULL
* pricepernight: DECIMAL, NOT NULL
* created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
* updated_at: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP
## Booking
* booking_id: Primary Key, UUID, Indexed
* property_id: Foreign Key, references Property(property_id)
* user_id: Foreign Key, references User(user_id)
* start_date: DATE, NOT NULL
* end_date: DATE, NOT NULL
* total_price: DECIMAL, NOT NULL
* status: ENUM (pending, confirmed, canceled), NOT NULL
* created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
## Payment
* payment_id: Primary Key, UUID, Indexed
* booking_id: Foreign Key, references Booking(booking_id)
* amount: DECIMAL, NOT NULL
* payment_date: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
* payment_method: ENUM (credit_card, paypal, stripe), NOT NULL
## Review
* review_id: Primary Key, UUID, Indexed
* property_id: Foreign Key, references Property(property_id)
* user_id: Foreign Key, references User(user_id)
* rating: INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL
* comment: TEXT, NOT NULL
* created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
## Message
* message_id: Primary Key, UUID, Indexed
* sender_id: Foreign Key, references User(user_id)
* recipient_id: Foreign Key, references User(user_id)
* message_body: TEXT, NOT NULL
* sent_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

# Constraints
## User Table
* Unique constraint on email.
* Non-null constraints on required fields.
## Property Table
* Foreign key constraint on host_id.
* Non-null constraints on essential attributes.
## Booking Table
* Foreign key constraints on property_id and user_id.
* status must be one of pending, confirmed, or canceled.
## Payment Table
* Foreign key constraint on booking_id, ensuring payment is linked to valid bookings.
## Review Table
* Constraints on rating values (1-5).
* Foreign key constraints on property_id and user_id.
## Message Table
* Foreign key constraints on sender_id and recipient_id.
# Indexing
* Primary Keys: Indexed automatically.
* Additional Indexes:
     * email in the User table.
     * property_id in the Property and Booking tables.
     * booking_id in the Booking and Payment tables.
 
# Detailed Explanation of Relationships:
## User Hosts Property (One-to-Many):

* Description: A User (specifically, a user with the 'host' role) can host multiple Property listings. Each Property is owned and listed by exactly one User (host).
* Notation: User | --O< Hosts -- Property
* Database Implication: Property table has host_id (FK) referencing User.user_id.
## User Books Booking (One-to-Many):

* Description: A User (acting as a guest) can make multiple Bookings. Each Booking is made by exactly one User.
* Notation: User | --O< Books -- Booking
* Database Implication: Booking table has user_id (FK) referencing User.user_id.

## Property Has Booking (One-to-Many):

* Description: A Property can have multiple Bookings associated with it over time. Each Booking is for exactly one Property.
* Notation: Property | --O< Has -- Booking
* Database Implication: Booking table has property_id (FK) referencing Property.property_id.

## Booking Generates Payment (One-to-One or One-to-Many, depending on specific rules, but often One-to-One for simplicity):

* Description: A Booking generates one and only one Payment. (While a booking might theoretically have multiple partial payments, the schema implies a single final payment for a booking_id).
* Notation: Booking | --| | Generates -- Payment (Assuming a one-to-one or one-to-optional-one where the payment always exists if the booking is confirmed). If a booking must have a payment, it's |--| |. If it might not (e.g., pending), it would be |--O|. Given the booking_id in Payment is a FK, implying linking, |--| | is a strong fit.
* Database Implication: Payment table has booking_id (FK) referencing Booking.booking_id. A unique constraint on booking_id in Payment would enforce a strict one-to-one relationship.
## User Provides Review (One-to-Many):

* Description: A User can provide multiple Reviews (for different properties or even the same property if allowed after different stays). Each Review is written by exactly one User.
* Notation: User | --O< Provides -- Review
* Database Implication: Review table has user_id (FK) referencing User.user_id.

## Property Receives Review (One-to-Many):

* Description: A Property can receive multiple Reviews from different users. Each Review is for exactly one Property.
* Notation: Property | --O< Receives -- Review
* Database Implication: Review table has property_id (FK) referencing Property.property_id.

## User Sends Message (Many-to-Many via Message entity):

* Description: A User can send multiple Messages, and a User can receive multiple Messages. This is a self-referencing many-to-many relationship.
* Notation: User | --O< Sends -- Message and User | --O< Receives -- Message (implicitly, as Message has both sender_id and recipient_id).
* Database Implication: Message table has sender_id (FK) and recipient_id (FK), both referencing User.user_id.





### https://drive.google.com/file/d/11DQSAVa1hTUNtj-sCgNOKoNU-yCGdno0/view?usp=sharing
