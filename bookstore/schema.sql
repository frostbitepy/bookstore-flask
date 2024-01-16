-- Eliminar las tablas existentes si existen
DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS publishers;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS authors;

-- Tabla para autores
CREATE TABLE authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL
);

-- Tabla para géneros
CREATE TABLE genres (
    genre_id INT PRIMARY KEY,
    genre_name VARCHAR(50) NOT NULL
);

-- Tabla para editoriales
CREATE TABLE publishers (
    publisher_id INT PRIMARY KEY,
    publisher_name VARCHAR(100) NOT NULL,
    location VARCHAR(100)
);

-- Tabla para libros
CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(13) UNIQUE,
    publication_year INT,
    author_id INT,
    genre_id INT,
    publisher_id INT,
    price DECIMAL(10, 2),
    stock_quantity INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id),
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id)
);

-- Tabla para usuarios
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

-- Tabla para órdenes
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    status VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Tabla para detalles de órdenes
CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);