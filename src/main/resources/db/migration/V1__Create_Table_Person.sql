CREATE TABLE IF NOT EXISTS person (
  id BIGSERIAL PRIMARY KEY,
  first_name varchar(80) NOT NULL,
  last_name varchar(80) NOT NULL,
  address varchar(100) NOT NULL,
  gender varchar(6) NOT NULL,
  enabled BOOLEAN NOT NULL DEFAULT TRUE
);