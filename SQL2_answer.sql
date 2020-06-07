-- PRACTICE JOINS 

SELECT * FROM invoice_line
WHERE unit_price > 0.99;

SELECT customer.first_name, customer.last_name, invoice.total, invoice.invoice_date
FROM customer
INNER JOIN invoice ON customer.customer_id = invoice.customer_id;

SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
INNER JOIN employee e ON e.employee_id = c.support_rep_id;

SELECT album.title, artist.name 
FROM album 
JOIN artist ON album.artist_id = artist.artist_id;

SELECT playlist_track.track_id
FROM playlist_track
JOIN playlist ON playlist_track.playlist_id = playlist.playlist_id
WHERE playlist.name = 'Music';

SELECT track.name
FROM track
JOIN playlist_track ON playlist_track.track_id = track.track_id
WHERE playlist_track.playlist_id = 5;

SELECT track.name, playlist.name
FROM track
JOIN playlist_track ON track.track_id = playlist_track.track_id
JOIN playlist ON playlist.playlist_id = playlist_track.playlist_id;

SELECT track.name, album.title
FROM track
JOIN genre ON track.genre_id = genre.genre_id
JOIN album ON album.album_id = track.album_id
WHERE genre.name = 'Alternative & Punk';

-- PRACTICE NESTED QUERIES

SELECT * 
FROM invoice
WHERE invoice_id IN (SELECT invoice_id FROM invoice_line WHERE unit_price > .99);

SELECT * 
FROM playlist_track
WHERE playlist_id IN (SELECT playlist_id FROM playlist WHERE name = 'Music');

SELECT name 
FROM track
WHERE track_id IN (SELECT playlist_id FROM playlist_track WHERE playlist_id = 5);

SELECT * 
FROM track
WHERE genre_id IN (SELECT genre_id FROM genre WHERE name = 'Comedy');

SELECT * 
FROM track 
WHERE album_id IN (SELECT album_id from album WHERE title = 'Fireball');

SELECT * 
FROM track 
WHERE album_id IN (
  SELECT album_id FROM album WHERE artist_id IN (
    SELECT artist_id FROM artist WHERE name = 'Queen'
  )
);

-- PRACTICE UPDATING ROWS

UPDATE customer
SET fax = NULL
WHERE fax IS NOT NULL;

UPDATE customer 
SET company = 'self'
WHERE company IS NULL;

UPDATE customer 
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';

UPDATE customer 
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = ( SELECT genre_id FROM genre WHERE name = 'Metal' )
AND composer IS null;

-- GROUP BY

SELECT COUNT(*), genre.name
FROM track 
JOIN genre on track.genre_id = genre.genre_id
GROUP BY genre.name;

SELECT COUNT(*), genre.name
FROM track
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name = 'Pop' OR genre.name = 'Rock'
GROUP BY genre.name;

SELECT COUNT(*), artist.name
FROM album 
JOIN artist ON artist.artist_id = album.artist_id
GROUP BY artist.name;

-- DISTINCT

SELECT DISTINCT composer
FROM track; 

SELECT DISTINCT billing_postal_code
FROM invoice;

SELECT DISTINCT company
FROM customer;

-- DELETE

DELETE 
FROM practice_delete 
WHERE type = 'bronze';

DELETE 
FROM practice_delete 
WHERE type = 'silver';

DELETE 
FROM practice_delete 
WHERE value = 150;

-- eCommerce Simulation 

CREATE TABLE users (
  users_id SERIAL PRIMARY KEY,
  name TEXT,
  email TEXT
);

CREATE TABLE products (
  product_id SERIAL PRIMARY KEY,
  name TEXT,
  price INT
);

CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  product_id INT REFERENCES products(product_id),
  users_id INT REFERENCES users(users_id),
  quantity INT
 );

INSERT INTO users 
(name, email)
VALUES
('egg', 'egg@egg.com');

INSERT INTO users 
(name, email)
VALUES
('dog', 'dog@dog.com');

INSERT INTO users 
(name, email)
VALUES
('cat', 'cat@cat.com');

INSERT INTO products
(name, price)
VALUES
('milk', 3);

INSERT INTO products
(name, price)
VALUES
('water', 1);

INSERT INTO products
(name, price)
VALUES
('shirt', 2);

SELECT * FROM products 
JOIN orders ON orders.product_id = products.product_id
WHERE orders.order_id = 1

SELECT * FROM orders;

SELECT orders.order_id sum(products.price * orders.quantity)
FROM orders 
JOIN products ON products.product_id = orders.product_id
GROUP BY orders.order_id;

SELECT * FROM users 
JOIN orders ON users.users_id = orders.users_id 
WHERE users.users_id = 2

