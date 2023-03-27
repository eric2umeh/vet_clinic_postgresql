/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(250) NOT NULL,
  date_of_birth DATE,
  escape_attempts INT,
  neutered BOOLEAN,
  weight_kg Decimal,
  PRIMARY KEY(id)
);