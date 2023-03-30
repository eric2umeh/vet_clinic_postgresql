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

/* Milestone 3 */

-- Create a table named owners & species
CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name TEXT,
    age INT,
    PRIMARY KEY(id)
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    PRIMARY KEY(id)
);

-- ALter animal tabl: Change id to auto_increment, DROP species column ADD species_id, owner_id as foreign keys
ALTER TABLE animals DROP COLUMN id;
ALTER TABLE animals ADD COLUMN id SERIAL PRIMARY KEY;
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals
ADD COLUMN species_id INT REFERENCES species(id),
ADD COLUMN owner_id INT REFERENCES owners(id);