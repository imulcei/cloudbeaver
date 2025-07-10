CREATE TABLE categories (
    id SERIAL NOT NULL PRIMARY KEY,
    "name" VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE clients (
    id SERIAL NOT NULL PRIMARY KEY,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    subscription_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE products (
    id SERIAL NOT NULL PRIMARY KEY,
    "name" VARCHAR(150) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    date_added TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE orders (
    id SERIAL NOT NULL PRIMARY KEY,
    client_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20),
    total DECIMAL(10,2),
    FOREIGN KEY (client_id) REFERENCES clients(id)
);

CREATE TABLE order_products (
    id SERIAL NOT NULL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO categories ("name", description) VALUES 
('Livres', 'Arts et littérature'),
('Informatique', 'Équipements et accessoires d''informatique'),
('Jardin', 'Articles pour le jardin');

INSERT INTO clients (last_name, first_name, email, phone_number, subscription_date) VALUES
('Doe', 'John', 'john.doe@mail.com', '0625312451', CURRENT_DATE),
('Martin', 'Arthur', 'arthurm@mail.com', '0298156234', CURRENT_DATE),
('Alvarez', 'Maria', 'marialva@mail.com', '0126359461', CURRENT_DATE),
('Poe', 'Edgar Allan', 'theblackcat@mail.com', '0561324895', CURRENT_DATE);

INSERT INTO products ("name", price, stock, category_id) VALUES
('Jules Verne - Biographie', 7.99, 26, 1),
('Ordinateur Lenovo', 799.99, 25, 2),
('Plante verte', 24.99, 40, 3),
('Guide de voyage', 19.99, 25, 1);

INSERT INTO orders (client_id, status, total) VALUES 
(1, 'PENDING', 824.98),
(2, 'SHIPPED', 24.99),
(3, 'DELIVERED', 44.98),
(1, 'PENDING', 27.99),
(4, 'CONFIRMED', 799.99);

INSERT INTO order_products (order_id, product_id, quantity, unit_price) VALUES 
(1, 1, 1, 799.99),
(1, 3, 1, 24.99),
(2, 3, 1, 24.99),
(3, 3, 1, 24.99),
(3, 4, 1, 19.99),
(4, 3, 1, 24.99),
(4, 1, 1, 7.99),
(5, 2, 1, 799.99);

SELECT p.name, p.price, c.name as categorie FROM products p JOIN categories c ON p.category_id = c.id;
SELECT o.id, cl.first_name, cl.last_name, o.order_date, o.status, o.total FROM orders o JOIN clients cl ON o.client_id = cl.id;