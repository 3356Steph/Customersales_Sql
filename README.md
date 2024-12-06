# Customer Sales Project

This repository contains SQL files related to the **Customer Sales** project. The project is aimed at managing customer sales data, generating reports, and performing data migrations.

## Project Structure
- **reports/**: Contains SQL queries to generate various sales reports.
- **queries/**: Includes SQL queries for customer transactions and related data.
- **migrations/**: Holds SQL scripts for updating customer data and making schema changes.

## Files in this repository

### 1. `sales_summary.sql`
This query generates a summary of sales data, including total sales, average order value, and sales by region.

### 2. `customer_transactions.sql`
This query retrieves customer transaction history, showing all purchases, products, and amounts spent.

### 3. `update_customer_data.sql`
This migration script updates customer records with new address information and other details.

## How to Run
1. Connect to your MySQL database.
2. Run the queries in the respective SQL files.
3. Adjust the queries according to your database schema if necessary.

## License
This project is licensed under the MIT License.

customer-sales/
├── reports/
│    └── sales_summary.sql
├── queries/
│    └── customer_transactions.sql
└── migrations/
     └── update_customer_data.sql
README.md
.gitignore

