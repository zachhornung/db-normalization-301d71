-- creating a copy of the database so that we dont break the production db
CREATE DATABASE lab14_normal WITH TEMPLATE lab14;

-- make the authors table
CREATE TABLE AUTHORS (id SERIAL PRIMARY KEY, name VARCHAR(255));

-- selects all of the authors that are unique in books
INSERT INTO authors(name) SELECT DISTINCT author FROM books;

-- create a column 
ALTER TABLE books ADD COLUMN author_id INT;
UPDATE books SET author_id=author.id FROM (SELECT * FROM authors) AS author WHERE books.author = author.name;
ALTER TABLE books DROP COLUMN author;
ALTER TABLE books ADD CONSTRAINT fk_authors FOREIGN KEY (author_id) REFERENCES authors(id);