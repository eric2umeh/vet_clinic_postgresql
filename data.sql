/* Populate database with sample data. */

/* Milestone 1 */
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) OVERRIDING SYSTEM VALUE VALUES (1, 'Agumon','2020-02-03', 0, TRUE, 10.23);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) OVERRIDING SYSTEM VALUE VALUES (2, 'Gabumon', '2018-11-15', 2, TRUE, 8);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) OVERRIDING SYSTEM VALUE VALUES (3, 'Pikachu', '2021-01-07', 1, FALSE, 15.04);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) OVERRIDING SYSTEM VALUE VALUES (4, 'Devimon', '2017-05-12', 5, TRUE, 11);

/* Milestone 2 */
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) OVERRIDING SYSTEM VALUE VALUES (5, 'Charmander', '2020-02-08', 0, false, -11);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) OVERRIDING SYSTEM VALUE VALUES (6, 'Plantmon', '2021-11-15', 2, true, -5.7);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) OVERRIDING SYSTEM VALUE VALUES (7, 'Squirtle', '1993-04-02', 3, false, -12.13);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) OVERRIDING SYSTEM VALUE VALUES (8, 'Angemon', '2005-06-12', 1, true, -45);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) OVERRIDING SYSTEM VALUE VALUES (9, 'Boarmon', '2005-06-07', 7, TRUE, 20.4);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) OVERRIDING SYSTEM VALUE VALUES (10, 'Blossom', '1998-10-13', 3, TRUE, 17);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) OVERRIDING SYSTEM VALUE VALUES (11, 'Ditto', '2022-05-14', 4, true, 22);

/* Milestone 3 */

-- insert respective data into owners and species tables
INSERT INTO owners (full_name,age)
VALUES
('Sam Smith',34),
('Jennifer Orwell',19),
('Bob',45),
('Melody Pond',77),
('Dean Winchester',14),
('Jodie Whittaker',38);
SELECT * FROM owners;
INSERT INTO species (name)
VALUES
('Pokemon'),
('Digimon');
SELECT * FROM species;

-- Update species_id values for Digimon & Pokemon 
BEGIN WORK;
UPDATE animals
SET species_id=2
WHERE name LIKE '%mon';
SELECT * FROM animals;
COMMIT WORK;

BEGIN WORK;
UPDATE animals
SET species_id=1
WHERE species_id IS NULL;
SELECT * FROM animals;
COMMIT WORK;

-- Modify inserted animals to include owner information (owner_id)
BEGIN WORK;
UPDATE animals SET owner_id=1 WHERE name IN ('Agumon');
UPDATE animals SET owner_id=2 WHERE name IN ('Gabumon','Pikachu');
UPDATE animals SET owner_id=3 WHERE name IN ('Devimon','Plantmon');
UPDATE animals SET owner_id=4 WHERE name IN ('Charmander','Squirtle','Blossom');
UPDATE animals SET owner_id=5 WHERE name IN ('Angemon','Boarmon');
SELECT * FROM animals;
COMMIT WORK;