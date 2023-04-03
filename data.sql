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

/* Milestone 4 */

-- insert data for vets, specialities and visits tables
BEGIN WORK;
INSERT INTO vets (name,age,date_of_graduation)
VALUES
('William Tatcher',45,'Apr 23,2000'),
('Maisy Smith',26,'Jan 17,2019'),
('Stephanie Mendez',64,'May 4,1981'),
('Jack Harkness',38,'Jun 8,2008');
SELECT * FROM vets;
COMMIT WORK;

BEGIN WORK;
INSERT INTO specializations (vet_id,species_id)
VALUES
(1,1),
(3,2),
(3,1),
(4,2);
SELECT * FROM specializations;
COMMIT WORK;

BEGIN WORK;
INSERT INTO visits (animal_id,vet_id,visit_date)
VALUES
(5,1,'May 24,2020'),
(1,3,'July 22,2020'),
(6,4,'Feb 2,2021'),
(9,2,'Jan 5,2020'),
(9,2,'Mar 8,2020'),
(9,2,'May 14,2020'),
(7,3,'May 4,2021'),
(3,4,'Feb 24,2021'),
(1,2,'Dec 21,2019'),
(1,1,'Aug 10,2020'),
(1,2,'Apr 7,2021'),
(4,3,'Sep 29,2019'),
(2,4,'Oct 3,2020'),
(2,4,'Nov 4,2020'),
(8,2,'Jan 24,2019'),
(8,2,'May 15,2019'),
(8,2,'Feb 27,2020'),
(8,2,'Aug 3,2020'),
(10,3,'May 24,2020'),
(10,1,'Jan 11,2021');
SELECT * FROM visits;
COMMIT WORK;

/* Database performance */

-- This will add 3.594.280 visits considering you have 10 animals, 
-- 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
BEGIN WORK;
INSERT INTO visits (animal_id, vet_id, visit_date) 
SELECT * FROM (SELECT id FROM animals) animal_ids, 
(SELECT id FROM vets) vets_ids, 
generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' 
-- and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) 
select 'Owner ' || generate_series(1,2500000), 
'owner_' || generate_series(1,2500000) || '@mail.com';