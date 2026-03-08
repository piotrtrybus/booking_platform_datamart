# Data Mart for Accommodation Booking Platform

## Overview
This project implements a relational **data mart for an accommodation booking platform** similar to Airbnb.  
The system stores and manages data related to users, properties, bookings, payments, messaging, and reviews.

The database was implemented using:

- **DuckDB** as the database engine  
- **DBeaver** as the SQL client

The objective was to design a structured relational model that supports the core functionality of a booking platform while maintaining consistent and scalable data management.

---

## Data Model

The data mart consists of multiple entities connected through **foreign key relationships** and grouped by platform functionality.

### User Management
Tables:
- `users`
- `guests`
- `hosts`
- `admins`

The `users` table stores general information about all platform users, while role-specific tables extend it with attributes relevant to guests, hosts, and administrators.

### Property Management
Tables:
- `properties`
- `property_photos`
- `amenities`
- `property_amenities`
- `cancellation_policy`

These tables manage property listings, including descriptions, amenities, photos, and cancellation rules.  
`property_amenities` represents a **many-to-many relationship** between properties and amenities.

### Booking Management
Tables:
- `bookings`
- `booking_statuses`
- `booking_cancellations`

The `bookings` table is the central entity and links guests, hosts, and properties.  
Booking states are stored in the `booking_statuses` lookup table.

### Communication & Reviews
Tables:
- `messages`
- `property_ratings`
- `disputes`

These entities enable communication between users, submission of property reviews, and dispute handling.

### Payments
Tables:
- `payments`
- `refunds`
- `payment_methods`
- `payment_statuses`
- `payment_providers`

These tables manage financial transactions related to bookings, including payment methods, providers, statuses, and refunds.

---

## System Functionality

The data mart supports the main operations of a booking platform:

**User Management**
- Stores user profiles and role information for guests, hosts, and administrators.

**Property Listings**
- Hosts can create and manage property listings.
- Properties can have multiple amenities and photos.

**Booking Management**
- Guests can create reservations for selected date ranges.
- Bookings connect guests, hosts, properties, and pricing data.
- Booking statuses track reservation progress.

**Payments**
- Payments are linked to bookings and include transaction details.
- Refunds are stored separately for returned payments.

**Communication & Feedback**
- Users can send messages related to bookings.
- Guests can submit property ratings and reviews.
- Administrators manage disputes when necessary.

---

## Summary

The final data mart successfully implements the **entity-relationship model designed in earlier phases** and translates it into SQL tables with appropriate relationships.

The database structure supports all core use cases of an accommodation booking platform while demonstrating practical application of **relational database design, normalization, and SQL implementation**.
