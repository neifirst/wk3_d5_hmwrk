
DROP TABLE movies CASCADE;
DROP TABLE customers CASCADE;
DROP TABLE tickets CASCADE;
DROP TABLE screenings CASCADE;

CREATE TABLE movies (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  price INT
);

CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  funds INT
);

CREATE TABLE tickets (
  id SERIAL PRIMARY KEY,
  movie_id INT REFERENCES movies(id) ON DELETE CASCADE,
  customer_id INT REFERENCES customers(id) ON DELETE CASCADE
);

CREATE TABLE screenings (
  id SERIAL PRIMARY KEY,
  movie_id INT REFERENCES movies(id) ON DELETE CASCADE,
  screen_time VARCHAR(255)
);
