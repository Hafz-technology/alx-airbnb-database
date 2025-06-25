/* # Entities and Attributes
## User
* user_id: Primary Key, UUID, Indexed
* first_name: VARCHAR, NOT NULL
* last_name: VARCHAR, NOT NULL
* email: VARCHAR, UNIQUE, NOT NULL
* password_hash: VARCHAR, NOT NULL
* phone_number: VARCHAR, NULL
* role: ENUM (guest, host, admin), NOT NULL
* created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP  
*/
CREATE TABLE User (
  user_id  NOT NULL ,
  first_name  NOT NULL,
  last_name  NOT NULL,
  email  NOT NULL ,
  password_hash  NOT NULL ,
  phone_number NOT NULL ,
  role  NOT NULL ,
  created_at  NOT NULL ,
  PRIMARY KEY  (user_id),
  KEY idx_actor_last_name (last_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*
## Property
* property_id: Primary Key, UUID, Indexed
* host_id: Foreign Key, references User(user_id)
* name: VARCHAR, NOT NULL
* description: TEXT, NOT NULL
* location: VARCHAR, NOT NULL
* pricepernight: DECIMAL, NOT NULL
* created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
* updated_at: TIMESTAMP, ON UPDATE CURRENT_TIMESTAMP 
*/
CREATE TABLE Property (
  property_id  NOT NULL ,
  host_id  NOT NULL,
  name  NOT NULL,
  description  NOT NULL ,
  location  NOT NULL ,
  pricepernight NOT NULL ,
  created_at  NOT NULL ,
  updated_at  NOT NULL ,
  PRIMARY KEY  (property_id),
  KEY idx_actor_last_name (last_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


/*
## Booking
* booking_id: Primary Key, UUID, Indexed
* property_id: Foreign Key, references Property(property_id)
* user_id: Foreign Key, references User(user_id)
* start_date: DATE, NOT NULL
* end_date: DATE, NOT NULL
* total_price: DECIMAL, NOT NULL
* status: ENUM (pending, confirmed, canceled), NOT NULL
* created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
*/
CREATE TABLE Booking (
  booking_id  NOT NULL ,
  property_id  NOT NULL,
  user_id  NOT NULL,
  start_date  NOT NULL ,
  end_date  NOT NULL ,
  total_price NOT NULL ,
  status  NOT NULL ,
  created_at  NOT NULL ,
  PRIMARY KEY  (booking_id),
  KEY idx_actor_last_name (last_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


/*
## Payment
* payment_id: Primary Key, UUID, Indexed
* booking_id: Foreign Key, references Booking(booking_id)
* amount: DECIMAL, NOT NULL
* payment_date: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
* payment_method: ENUM (credit_card, paypal, stripe), NOT NULL
*/
CREATE TABLE Payment (
  payment_id  NOT NULL ,
  booking_id  NOT NULL,
  amount  NOT NULL,
  payment_date  NOT NULL ,
  payment_method  NOT NULL ,
  PRIMARY KEY  (payment_id),
  KEY idx_actor_last_name (last_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;




/*
## Review
* review_id: Primary Key, UUID, Indexed
* property_id: Foreign Key, references Property(property_id)
* user_id: Foreign Key, references User(user_id)
* rating: INTEGER, CHECK: rating >= 1 AND rating <= 5, NOT NULL
* comment: TEXT, NOT NULL
* created_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP
*/


/*
## Message
* message_id: Primary Key, UUID, Indexed
* sender_id: Foreign Key, references User(user_id)
* recipient_id: Foreign Key, references User(user_id)
* message_body: TEXT, NOT NULL
* sent_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

*/

--
-- Table structure for table `actor`
--



