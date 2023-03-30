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

/* Milestone 4 */

-- Create tables vets, specializations, visits & join tables
CREATE TABLE vets (
id INT GENERATED ALWAYS AS IDENTITY,
name TEXT,
age INT,
date_of_graduation DATE,
PRIMARY KEY(id)
);

CREATE TABLE specializations (
vet_id INT REFERENCES vets(id),
species_id INT REFERENCES species(id),
PRIMARY KEY (vet_id,species_id)
);

CREATE TABLE visits(
animal_id INT REFERENCES animals(id),
vet_id INT REFERENCES vets(id),
visit_date DATE,
PRIMARY KEY(animal_id,vet_id,visit_date )
);
