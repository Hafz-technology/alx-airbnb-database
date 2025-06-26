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
  user_id INT NOT NULL AUTO_INCREMENT, 
  first_name VARCHAR(255) NOT NULL,    
  last_name VARCHAR(255) NOT NULL,     
  email VARCHAR(255) NOT NULL UNIQUE,  
  password_hash VARCHAR(255) NOT NULL, 
  phone_number VARCHAR(20) NOT NULL,   
  role ENUM('guest', 'host', 'admin') NOT NULL, 
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY (user_id),
  INDEX idx_user_last_name (last_name) 
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
  property_id VARCHAR(36) NOT NULL, -- UUIDs are typically stored as VARCHAR(36)
  host_id INT NOT NULL,             -- Foreign Key referencing User(user_id)
  name VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  location VARCHAR(255) NOT NULL,
  price_per_night DECIMAL(10, 2) NOT NULL, -- Example: 10 total digits, 2 after decimal
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, -- Automatically updates on row modification
  PRIMARY KEY (property_id),
  INDEX idx_property_id (property_id), -- Indexing the primary key for efficiency
  FOREIGN KEY (host_id) REFERENCES User(user_id) -- Foreign key constraint to User table
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
  booking_id VARCHAR(36) NOT NULL, -- UUIDs are typically stored as VARCHAR(36)
  property_id VARCHAR(36) NOT NULL, -- Foreign Key referencing Property(property_id)
  user_id INT NOT NULL,             -- Foreign Key referencing User(user_id)
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  total_price DECIMAL(10, 2) NOT NULL, -- Example: 10 total digits, 2 after decimal
  status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (booking_id),
  INDEX idx_booking_id (booking_id), -- Indexing the primary key for efficiency
  FOREIGN KEY (property_id) REFERENCES Property(property_id), -- Foreign key constraint to Property table
  FOREIGN KEY (user_id) REFERENCES User(user_id)              -- Foreign key constraint to User table
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
  payment_id VARCHAR(36) NOT NULL, -- UUIDs are typically stored as VARCHAR(36)
  booking_id VARCHAR(36) NOT NULL, -- Foreign Key referencing Booking(booking_id)
  amount DECIMAL(10, 2) NOT NULL,    -- Example: 10 total digits, 2 after decimal
  payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
  PRIMARY KEY (payment_id),
  INDEX idx_payment_id (payment_id), -- Indexing the primary key for efficiency
  FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) -- Foreign key constraint to Booking table
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
CREATE TABLE Review (
  review_id VARCHAR(36) NOT NULL, -- UUIDs are typically stored as VARCHAR(36)
  property_id VARCHAR(36) NOT NULL, -- Foreign Key referencing Property(property_id)
  user_id INT NOT NULL,             -- Foreign Key referencing User(user_id)
  rating INTEGER NOT NULL,
  comment TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (review_id),
  INDEX idx_review_id (review_id), -- Indexing the primary key for efficiency
  FOREIGN KEY (property_id) REFERENCES Property(property_id), -- Foreign key constraint to Property table
  FOREIGN KEY (user_id) REFERENCES User(user_id),              -- Foreign key constraint to User table
  CHECK (rating >= 1 AND rating <= 5) -- Constraint to ensure rating is between 1 and 5
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


/*
## Message
* message_id: Primary Key, UUID, Indexed
* sender_id: Foreign Key, references User(user_id)
* recipient_id: Foreign Key, references User(user_id)
* message_body: TEXT, NOT NULL
* sent_at: TIMESTAMP, DEFAULT CURRENT_TIMESTAMP

*/
CREATE TABLE Message (
  message_id VARCHAR(36) NOT NULL, -- UUIDs are typically stored as VARCHAR(36)
  sender_id INT NOT NULL,           -- Foreign Key referencing User(user_id)
  recipient_id INT NOT NULL,        -- Foreign Key referencing User(user_id)
  message_body TEXT NOT NULL,
  sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (message_id),
  INDEX idx_message_id (message_id), -- Indexing the primary key for efficiency
  FOREIGN KEY (sender_id) REFERENCES User(user_id),    -- Foreign key constraint to User table for sender
  FOREIGN KEY (recipient_id) REFERENCES User(user_id) -- Foreign key constraint to User table for recipient
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;











