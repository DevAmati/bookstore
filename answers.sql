--creating database bookstore_db
CREATE DATABASE bookstore_db;
USE bookstore_db;

--creting  tables
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_name VARCHAR(100) NOT NULL
);

CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    phone_number VARCHAR(20)
);

CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    language_id INT,
    title VARCHAR(255) NOT NULL,
    publication_year YEAR,
    price DECIMAL(10,2),
    quantity INT,
    publisher_id INT,
    FOREIGN KEY (language_id) REFERENCES book_language(language_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    book_id INT,
    bio TEXT,
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(20)
);

CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    address_line VARCHAR(255),
    city VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50)
);

CREATE TABLE customer_address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    address_line VARCHAR(255),
    city VARCHAR(100),
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (country_id) REFERENCES country(country_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100)
);

CREATE TABLE customer_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    shipping_method_id INT,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id)
);

CREATE TABLE order_line (
    order_line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES customer_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50)
);

CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES customer_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);



--Managing database access using user groups and roles
CREATE USER 'bookstore_admin'@'localhost' IDENTIFIED BY 'AdminPass123!';
CREATE USER 'bookstore_staff'@'localhost' IDENTIFIED BY 'StaffPass123!';

--granting the admin full access to the database
GRANT ALL PRIVILEGES ON bookstore_db.* TO 'bookstore_admin'@'localhost';

--staff
GRANT SELECT, INSERT, UPDATE ON bookstore_db.* TO 'bookstore_staff'@'localhost';

--applying priviliges
FLUSH PRIVILEGES;

--Revoking access
REVOKE INSERT ON bookstore_db.* FROM 'bookstore_staff'@'localhost';





