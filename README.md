## Quick Start Guide

This guide explains how to set up and explore the accommodation booking data mart.

### 1. Requirements

Before starting, ensure the following tools are installed:

- **DuckDB** – database engine used for the data mart  
- **DBeaver** (or any SQL client) – used to run SQL scripts and browse the database

### 2. Create the Database

1. Open **DBeaver**.
2. Create a new **DuckDB connection**.
3. Create a new database file (e.g. `booking_datamart.duckdb`).

### 3. Initialize the Schema

Run the provided SQL scripts in the following order:

1. **Schema creation**
   - Creates the main `booking` schema.

2. **Table creation**
   - Creates all entities such as:
     - users
     - properties
     - bookings
     - payments
     - messages
     - reviews

3. **Lookup tables**
   - booking statuses  
   - payment statuses  
   - payment providers  
   - payment methods

4. **Relationship tables**
   - property amenities
   - booking related entities

Running these scripts will generate the complete relational structure of the data mart.

### 4. Verify the Setup

After executing the scripts, confirm that the tables were created correctly:

```sql
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'booking';
