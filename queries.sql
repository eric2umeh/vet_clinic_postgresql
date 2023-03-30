/*Queries that provide answers to the questions from all projects.*/

/* Milestone 1 */
SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT name FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT name FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/* Milestone 2 */

-- Transactions to update and rollback animals table
BEGIN WORK;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;

-- Rollback changes made above
ROLLBACK;
SELECT * FROM animals;

-- Transactions to update the species column
BEGIN WORK;
UPDATE animals
SET species='digimon'
WHERE name LIKE '%mon';
SELECT * FROM animals;

UPDATE animals
SET species='pokemon'
WHERE species IS NULL;
SELECT * FROM animals;
COMMIT WORK;
SELECT * FROM animals;

-- Transaction to delete all records in the animals table, and ROLLBACK transaction to restore table to former state
BEGIN WORK;
DELETE FROM animals;
SELECT * FROM animals;

ROLLBACK;
SELECT * FROM animals;

-- Transactions with savepoints to update animal columns
BEGIN WORK;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SELECT * FROM animals;

SAVEPOINT SP1;

UPDATE animals
SET weight_kg = weight_kg*-1;
SELECT * FROM animals;

ROLLBACK TO SP1;

UPDATE animals
SET weight_kg = weight_kg*-1
WHERE weight_kg < 0;
SELECT * FROM animals;

COMMIT;

-- Aggregate functions
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered,SUM(escape_attempts) AS escapees FROM animals GROUP BY neutered;
SELECT species,MIN(weight_kg) AS minimum_weight,MAX(weight_kg) AS maximum_weight FROM animals GROUP BY species;
SELECT species,AVG(escape_attempts) AS avg_escapees FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'  GROUP BY species;

/* Milestone 3 */

-- Using queries (using JOIN) to answer the following questions
-- What animals belong to Melody Pond?
SELECT 
    full_name AS owner, 
    name AS animal  
FROM 
    animals 
JOIN owners OO
ON owner_id=OO.id 
WHERE full_name='Melody Pond';

--List of all animals that are pokemon (their type is Pokemon).
SELECT 
    AA.name AS animal, 
    SS.name AS species 
FROM 
    animals AA
JOIN species SS
ON AA.species_id=SS.id 
WHERE SS.name='Pokemon';

--List all owners and their animals, remember to include those that don't own any animal.
SELECT 
    OO.full_name AS owners,
    AA.name AS animals 
FROM 
    owners OO 
FULL OUTER JOIN animals AA 
ON OO.id=AA.owner_id;

--How many animals are there per species?
SELECT 
    SS.name, 
    COUNT(*) AS species 
FROM 
    animals AA 
JOIN species SS 
ON AA.species_id=SS.id 
GROUP BY SS.name;

--List all Digimon owned by Jennifer Orwell.
SELECT 
    O.full_name AS owner,
    A.name AS animal,
    S.name AS species 
FROM 
    owners O 
JOIN animals A 
ON O.id=A.owner_id 
JOIN species S 
ON A.species_id=S.id 
WHERE S.name='Digimon' AND  O.full_name='Jennifer Orwell';

--List all animals owned by Dean Winchester that haven't tried to escape.
SELECT 
    OO.full_name AS owner,
    AA.name AS animal 
FROM 
    owners OO 
JOIN animals AA 
ON OO.id=AA.owner_id 
WHERE OO.full_name='Dean Winchester' AND AA.escape_attempts=0;

--Who owns the most animals?
SELECT 
    owners.full_name,
    COUNT(animals.name) AS total_animalss
FROM 
    owners 
JOIN animals
ON animals.owner_id=owners.id
GROUP BY owners.full_name 
ORDER BY total_animalss DESC 
LIMIT 1;
