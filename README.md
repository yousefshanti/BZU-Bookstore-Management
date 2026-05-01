<img width="1440" height="849" alt="Screenshot 2026-01-18 at 11 25 24 AM" src="https://github.com/user-attachments/assets/44aa0e80-b762-4f9d-9dfe-7d5d28eb5a42" />

<img width="1440" height="849" alt="Screenshot 2026-01-18 at 11 25 16 AM" src="https://github.com/user-attachments/assets/28e13314-ebb3-4a80-9579-4c16815ce2b5" />
# 📚 Birzeit University Bookstore Management System

> **COMP333 – Database Systems** | Faculty of Engineering & Technology, Department of Computer Science  
> **Birzeit University**

---

## 👤 Author

| Name 
| Yousef Shanti 

**Instructor:** Dr. Ihab Alshaer  
**Date:** 18 / 1 / 2026

---

## 📌 Project Description

A **Bookstore Management System** designed to manage the process of selling and renting books to students and faculty members in an organized and efficient way.

The system stores and manages all important information related to the bookstore including books, authors, customers, suppliers, rentals, purchases, and stock levels. It replaces manual records with a centralized database that allows employees to:

- Track available books and stock quantities
- Record sales and rentals accurately
- Monitor inventory and reorder alerts
- Generate business performance reports

---

## ⚙️ Main System Functionality

- 📖 Recording book sales and rentals
- 📦 Managing book inventory
- 🚚 Tracking book deliveries from suppliers
- ✍️ Managing authors and book categories
- 📊 Viewing business performance through detailed reports

---

## 🗂️ Entity Sets

| Entity | Description | Primary Key |
|--------|-------------|-------------|
| **Book** | Individual books with title, category, price, and availability | `Book_ID` |
| **Author** | Authors linked to one or more books | `Author_ID` |
| **Customer** | Students or staff who purchase or rent books | `Customer_ID` |
| **Supplier** | Companies that provide books to the bookstore | `Supplier_ID` |
| **Sale** | Sale transactions recording book sold to a customer on a date | `Sale_ID` |
| **Rental** | Rental transactions with rental date, due date, and return date | `Rental_ID` |
| **Stock** | Inventory records tracking available quantity of each book | `Book_ID` |
| **Category** | Classifies books by subject (IT, History, Medicine, etc.) | `Category_ID` |

---

## 🔗 Relationships

- Each category can have multiple books
- Each supplier can supply multiple books
- Each customer can perform multiple sales
- Each customer can rent multiple books
- Each book can appear in multiple sales
- Each book can appear in multiple rentals
- Each book has exactly one stock record

---

## 🗃️ Normalization & Schema

The database was normalized to **Third Normal Form (3NF)** by separating Authors, Categories, and Suppliers into independent tables to avoid data redundancy. Author details are stored only once, eliminating duplication and improving data consistency.

---

## 🔍 SQL Queries

### 📘 Book Queries

```sql
-- Retrieve all available books sorted by title
SELECT * FROM books
WHERE availability = 1
ORDER BY title ASC;

-- Retrieve books by a specific category
SELECT b.*
FROM books b
JOIN categories c ON b.category_id = c.category_id
WHERE c.category_name = 'IT';

-- Retrieve authors of a selected book
SELECT a.author_name
FROM authors a
JOIN book_authors ba ON a.author_id = ba.author_id
WHERE ba.book_id = 1;

-- Retrieve books with low stock (less than 10 copies)
SELECT b.title, s.quantity
FROM books b
JOIN stock s ON b.book_id = s.book_id
WHERE s.quantity < 10;

-- Count the number of books in each category
SELECT c.category_name, COUNT(b.book_id) AS book_count
FROM categories c
LEFT JOIN books b ON c.category_id = b.category_id
GROUP BY c.category_id;
```

### 👥 Customer & Sales Queries

```sql
-- Retrieve all customers sorted by name
SELECT * FROM customers
ORDER BY customer_name ASC;

-- Retrieve the top 5 best-selling books
SELECT b.title, COUNT(s.sale_id) AS sales_count
FROM books b
JOIN sales s ON b.book_id = s.book_id
GROUP BY b.book_id
ORDER BY sales_count DESC
LIMIT 5;

-- Retrieve sales details for a specific customer
SELECT s.*, b.title
FROM sales s
JOIN books b ON s.book_id = b.book_id
WHERE s.customer_id = 1;

-- Retrieve books purchased on a specific date
SELECT b.title
FROM books b
JOIN sales s ON b.book_id = s.book_id
WHERE DATE(s.sale_date) = '2024-01-15';
```

### 📦 Rental Queries

```sql
-- Retrieve all overdue rentals
SELECT b.title, c.customer_name, r.due_date
FROM rentals r
JOIN books b ON r.book_id = b.book_id
JOIN customers c ON r.customer_id = c.customer_id
WHERE r.return_date IS NULL AND r.due_date < NOW();

-- Retrieve all rented books with their return dates
SELECT b.title, r.rental_date, r.return_date
FROM rentals r
JOIN books b ON r.book_id = b.book_id;

-- Count total number of active rentals
SELECT COUNT(*) AS active_rentals
FROM rentals
WHERE return_date IS NULL;

-- Retrieve rental history for a specific customer
SELECT b.title, r.rental_date, r.return_date
FROM rentals r
JOIN books b ON r.book_id = b.book_id
WHERE r.customer_id = 1;

-- Retrieve most rented categories
SELECT c.category_name, COUNT(r.rental_id) AS rental_count
FROM categories c
JOIN books b ON c.category_id = b.category_id
JOIN rentals r ON b.book_id = r.book_id
GROUP BY c.category_id
ORDER BY rental_count DESC;
```

### 🏭 Supplier & Inventory Queries

```sql
-- Retrieve all suppliers sorted by company name
SELECT * FROM suppliers
ORDER BY company_name ASC;

-- Retrieve books supplied by a specific supplier
SELECT b.title FROM books b
WHERE b.supplier_id = 1;

-- Retrieve supplier contact info for a selected book
SELECT s.company_name, s.supplier_email, s.supplier_phone
FROM suppliers s
JOIN books b ON s.supplier_id = b.supplier_id
WHERE b.book_id = 1;

-- Retrieve stock quantity for each book
SELECT b.title, s.quantity
FROM books b
JOIN stock s ON b.book_id = s.book_id;

-- Retrieve total inventory value
SELECT SUM(b.price * s.quantity) AS total_inventory_value
FROM books b
JOIN stock s ON b.book_id = s.book_id;
```

---

## 🖥️ System Screenshots

### Store Books UI
Displays available books with titles, categories, prices, and stock quantities in a clean browsable interface.

### Admin Dashboard
Shows system reports including:
- ⚠️ Low stock alerts
- ⏰ Overdue rentals
- 📊 Books per category (chart)
- 💰 Total sales revenue

---

## 🛠️ Tech Stack

![MySQL](https://img.shields.io/badge/MySQL-Database-blue?logo=mysql)
![HTML](https://img.shields.io/badge/HTML-Frontend-orange?logo=html5)
![CSS](https://img.shields.io/badge/CSS-Styling-blue?logo=css3)
![JavaScript](https://img.shields.io/badge/JavaScript-Logic-yellow?logo=javascript)

---

*Faculty of Engineering & Technology – Birzeit University*
