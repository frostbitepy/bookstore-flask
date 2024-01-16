INSERT INTO authors (author_id, author_name) VALUES
    (1, 'J.K. Rowling'),
    (2, 'George Orwell'),
    (3, 'Agatha Christie'),
    (4, 'Haruki Murakami'),
    (5, 'Jane Austen');

INSERT INTO genres (genre_id, genre_name) VALUES
    (1, 'Fantasy'),
    (2, 'Dystopian'),
    (3, 'Mystery'),
    (4, 'Contemporary'),
    (5, 'Romance');

INSERT INTO publishers (publisher_id, publisher_name, location) VALUES
    (1, 'Penguin Random House', 'New York'),
    (2, 'HarperCollins', 'London'),
    (3, 'Simon & Schuster', 'New York'),
    (4, 'Random House', 'Berlin'),
    (5, 'Hachette Livre', 'Paris');

INSERT INTO books (book_id, title, isbn, publication_year, author_id, genre_id, publisher_id, price, stock_quantity) VALUES
    (1, 'Harry Potter and the Philosophers Stone', '9780747532743', 1997, 1, 1, 1, 29.99, 100),
    (2, '1984', '9780451524935', 1949, 2, 2, 2, 19.99, 50),
    (3, 'Murder on the Orient Express', '9780062693662', 1934, 3, 3, 3, 15.99, 75),
    (4, 'Norwegian Wood', '9780375704024', 1987, 4, 4, 4, 24.99, 60),
    (5, 'Pride and Prejudice', '9780141439518', 1813, 5, 5, 5, 12.99, 120);

INSERT INTO users (user_id, first_name, last_name, email, phone_number, address, username, password) VALUES
    (1, 'John', 'Doe', 'john.doe@example.com', '123-456-7890', '123 Main St', 'john_doe', 'hashed_password_1'),
    (2, 'Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '456 Oak St', 'jane_smith', 'hashed_password_2'),
    (3, 'Alice', 'Johnson', 'alice.johnson@example.com', '555-123-4567', '789 Pine St', 'alice_j', 'hashed_password_3'),
    (4, 'Bob', 'Williams', 'bob.williams@example.com', '777-888-9999', '321 Elm St', 'bob_w', 'hashed_password_4'),
    (5, 'Emily', 'Davis', 'emily.davis@example.com', '111-222-3333', '555 Maple St', 'emily_d', 'hashed_password_5');

INSERT INTO orders (order_id, user_id, order_date, total_amount, status) VALUES
    (1, 1, '2022-01-01', 49.99, 'Completed'),
    (2, 2, '2022-01-02', 39.99, 'Processing'),
    (3, 3, '2022-01-03', 29.99, 'Shipped'),
    (4, 4, '2022-01-04', 19.99, 'Pending'),
    (5, 5, '2022-01-05', 59.99, 'Completed');

INSERT INTO order_details (order_detail_id, order_id, book_id, quantity, price) VALUES
    (1, 1, 1, 2, 29.99),
    (2, 1, 2, 1, 19.99),
    (3, 2, 3, 3, 15.99),
    (4, 3, 4, 1, 24.99),
    (5, 4, 5, 4, 12.99);