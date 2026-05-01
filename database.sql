
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    supplier_email VARCHAR(100),
    supplier_phone VARCHAR(20)
);

CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL
);

CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    availability TINYINT(1) DEFAULT 1, 
    category_id INT,
    image VARCHAR(255) DEFAULT 'https://via.placeholder.com/150',
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE book_authors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);

CREATE TABLE stock (
    book_id INT PRIMARY KEY,
    quantity INT DEFAULT 0,
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100),
    customer_phone VARCHAR(20)
);

CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    sale_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    customer_id INT,
    book_id INT, 
    amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

CREATE TABLE rentals (
    rental_id INT AUTO_INCREMENT PRIMARY KEY,
    rental_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    due_date DATETIME,
    return_date DATETIME NULL,
    customer_id INT,
    book_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);


INSERT INTO categories (category_name) VALUES ('IT'), ('History'), ('Medicine'), ('Fiction');
INSERT INTO authors (author_name) VALUES ('Yamen Kharoub'), ('Yousef Shanti'), ('Dr. Ihab');
INSERT INTO suppliers (company_name, supplier_email) VALUES ('Birzeit Publishing', 'contact@birzeit.edu');

INSERT INTO books (title, price, category_id, image) VALUES 
('Database Systems', 50.00, 1, 'https://cdn-icons-png.flaticon.com/512/2232/2232688.png'),
('History of Palestine', 30.00, 2, 'https://cdn-icons-png.flaticon.com/512/2232/2232688.png'),
('Vue.js Guide', 45.00, 1, 'https://cdn-icons-png.flaticon.com/512/2232/2232688.png');

INSERT INTO stock (book_id, quantity) VALUES (1, 50), (2, 5), (3, 20); 
INSERT INTO book_authors (book_id, author_id) VALUES (1, 3), (2, 1), (3, 2);
INSERT INTO customers (customer_name) VALUES ('Student 1'), ('Faculty Member');


INSERT INTO sales (customer_id, book_id, amount, sale_date) VALUES (1, 1, 50.00, NOW()), (2, 3, 45.00, NOW());
INSERT INTO rentals (customer_id, book_id, rental_date, due_date) VALUES (1, 2, '2023-12-01', '2023-12-15');