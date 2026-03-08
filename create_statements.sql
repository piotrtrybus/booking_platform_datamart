CREATE SCHEMA IF NOT EXISTS booking;

CREATE TABLE booking.users (
  user_id INT NOT NULL,
  name VARCHAR,
  email VARCHAR,
  role VARCHAR,
  profile_picture VARCHAR,
  created_at TIMESTAMP,
  PRIMARY KEY (user_id)
);

CREATE TABLE booking.booking_statuses (
  id INT NOT NULL,
  name VARCHAR NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE booking.amenities (
  id INT NOT NULL,
  name VARCHAR NOT NULL,
  description VARCHAR,
  PRIMARY KEY (id)
);

CREATE TABLE booking.payment_methods (
  id INT NOT NULL,
  name VARCHAR NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE booking.payment_statuses (
  id INT NOT NULL,
  name VARCHAR NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE booking.payment_providers (
  id INT NOT NULL,
  name VARCHAR NOT NULL,
  contact_email VARCHAR,
  support_phone VARCHAR,
  PRIMARY KEY (id)
);


CREATE TABLE booking.guests (
  id INT NOT NULL,
  phone_number VARCHAR NOT NULL,
  profile_picture VARCHAR,
  email VARCHAR NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES booking.users(user_id)
);

CREATE TABLE booking.hosts (
  id INT NOT NULL,
  phone_number VARCHAR NOT NULL,
  profile_picture VARCHAR,
  payout_account VARCHAR,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES booking.users(user_id)
);

CREATE TABLE booking.admins (
  id INT NOT NULL,
  phone_number VARCHAR,
  email VARCHAR,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES booking.users(user_id)
);


CREATE TABLE booking.properties (
  id INT NOT NULL,
  name VARCHAR,
  description VARCHAR,
  address VARCHAR,
  city VARCHAR,
  country VARCHAR,
  latitude NUMERIC,
  longitude NUMERIC,
  nightly_price NUMERIC,
  host_id INT NOT NULL,
  created_at TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (host_id) REFERENCES booking.hosts(id)
);

CREATE TABLE booking.cancellation_policy (
  id INT NOT NULL,
  property_id INT NOT NULL,
  policy_type VARCHAR,
  description VARCHAR,
  PRIMARY KEY (id),
  FOREIGN KEY (property_id) REFERENCES booking.properties(id)
);

CREATE TABLE booking.property_photos (
  id INT NOT NULL,
  property_id INT NOT NULL,
  url VARCHAR NOT NULL,
  is_primary BOOLEAN,
  created_at TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (property_id) REFERENCES booking.properties(id)
);

CREATE TABLE booking.property_amenities (
  property_id INT NOT NULL,
  amenity_id INT NOT NULL,
  PRIMARY KEY (property_id, amenity_id),
  FOREIGN KEY (property_id) REFERENCES booking.properties(id),
  FOREIGN KEY (amenity_id) REFERENCES booking.amenities(id)
);


CREATE TABLE booking.bookings (
  id INT NOT NULL,
  property_id INT NOT NULL,
  guest_id INT NOT NULL,
  host_id INT NOT NULL,
  price NUMERIC,
  status_id INT NOT NULL,
  start_date DATE,
  end_date DATE,
  created_at TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (guest_id) REFERENCES booking.guests(id),
  FOREIGN KEY (host_id) REFERENCES booking.hosts(id),
  FOREIGN KEY (property_id) REFERENCES booking.properties(id),
  FOREIGN KEY (status_id) REFERENCES booking.booking_statuses(id)
);


CREATE TABLE booking.disputes (
  id INT NOT NULL,
  booking_id INT NOT NULL,
  opened_by_user_id INT NOT NULL,
  admin_id INT,
  reason VARCHAR NOT NULL,
  status VARCHAR,
  created_at TIMESTAMP,
  resolved_at TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (booking_id) REFERENCES booking.bookings(id),
  FOREIGN KEY (opened_by_user_id) REFERENCES booking.users(user_id),
  FOREIGN KEY (admin_id) REFERENCES booking.admins(id)
);


CREATE TABLE booking.messages (
  id INT NOT NULL,
  sender_id INT NOT NULL,
  receiver_id INT NOT NULL,
  booking_id INT NOT NULL,
  parent_message_id INT,
  subject VARCHAR,
  message VARCHAR,
  created_at TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (sender_id) REFERENCES booking.users(user_id),
  FOREIGN KEY (receiver_id) REFERENCES booking.users(user_id),
  FOREIGN KEY (booking_id) REFERENCES booking.bookings(id)
);


CREATE TABLE booking.payments (
  id INT NOT NULL,
  payer_id INT NOT NULL,
  payee_id INT NOT NULL,
  booking_id INT NOT NULL,
  amount NUMERIC,
  status_id INT NOT NULL,
  payment_method_id INT NOT NULL,
  payment_provider_id INT NOT NULL,
  created_at TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (payer_id) REFERENCES booking.guests(id),
  FOREIGN KEY (payee_id) REFERENCES booking.hosts(id),
  FOREIGN KEY (booking_id) REFERENCES booking.bookings(id),
  FOREIGN KEY (payment_method_id) REFERENCES booking.payment_methods(id),
  FOREIGN KEY (status_id) REFERENCES booking.payment_statuses(id),
  FOREIGN KEY (payment_provider_id) REFERENCES booking.payment_providers(id)
);

CREATE TABLE booking.refunds (
  id INT NOT NULL,
  payment_id INT NOT NULL,
  amount NUMERIC NOT NULL,
  created_at TIMESTAMP,
  status VARCHAR,
  PRIMARY KEY (id),
  FOREIGN KEY (payment_id) REFERENCES booking.payments(id)
);

CREATE TABLE booking.booking_cancellations (
	id INT,
	booking_id INT NOT NULL,
	cancelled_at TIMESTAMP NOT NULL,
	reason VARCHAR,
	refund_amount NUMERIC,
	PRIMARY KEY (id),
	FOREIGN KEY(booking_id) REFERENCES booking.bookings(id)
	);

CREATE TABLE booking.property_ratings (
	id INT,
	property_id INT NOT NULL,
	guest_id INT NOT NULL,
	booking_id INT NOT NULL,
	rating INT NOT NULL,
	description VARCHAR,
	created_at TIMESTAMP,
	PRIMARY KEY (id),
	FOREIGN KEY (property_id) REFERENCES booking.properties(id),
	FOREIGN KEY (guest_id) REFERENCES booking.guests(id),
	FOREIGN KEY (booking_id) REFERENCES booking.bookings(id)
	
