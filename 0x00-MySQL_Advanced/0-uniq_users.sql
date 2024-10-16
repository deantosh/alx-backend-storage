-- Write a SQL script that creates a table users following these requirements:
-- With these attributes:
--    id, integer, never null, auto increment and primary key
--    email, string (255 characters), never null and unique
--    name, string (255 characters)
-- If the table already exists, your script should not fail
-- Your script can be executed on any database

CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  name VARCHAR(255)
);
