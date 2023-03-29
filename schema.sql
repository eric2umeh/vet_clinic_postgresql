/* Database schema to keep the structure of entire database. */

/* Milestone 1 */
CREATE TABLE animals(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(250) NOT NULL,
  date_of_birth DATE,
  escape_attempts INT,
  neutered BOOLEAN,
  weight_kg Decimal,
  PRIMARY KEY(id)
);

/* Milestone 2 */

-- Alter Table by adding species column
ALTER TABLE animals ADD species VARCHAR(250);
