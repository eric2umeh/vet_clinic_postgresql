/*Queries that provide answers to the questions from all projects.*/

/* Milestone 1 */
-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT name FROM animals WHERE neutered = true;

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
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
-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered,SUM(escape_attempts) AS escapees FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species,MIN(weight_kg) AS minimum_weight,MAX(weight_kg) AS maximum_weight FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
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

/* Milestone 4 */

-- Queries to answer questions for milestone 4 project requirements
-- Who was the last animal seen by William Tatcher?
SELECT A.name, VET.name, V.visit_date 
FROM animals A 
JOIN visits V 
ON A.id = V.animal_id 
JOIN vets VET 
ON VET.id = V.vet_id 
WHERE VET.name = 'William Tatcher' 
ORDER BY V.visit_date DESC 
LIMIT 1 ;

-- How many different animals did Stephanie Mendez see?
SELECT VET.name, COUNT(DISTINCT V.animal_id) AS animal_seen 
FROM animals A 
JOIN visits V 
ON A.id = V.animal_id 
JOIN vets VET 
ON VET.id = V.vet_id 
WHERE VET.name = 'Stephanie Mendez' 
GROUP BY VET.name;

-- List all vets and their specialties, including vets with no specialties.
SELECT V.name AS vet_name, SP.name AS specialities 
FROM vets V 
FULL JOIN specializations S 
ON V.id = S.vet_id 
FULL JOIN species SP 
ON S.species_id = SP.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT A.name AS animal_name, VET.name AS vet_name, V.visit_date 
FROM animals A 
JOIN visits V 
ON A.id = V.animal_id 
JOIN vets VET 
ON V.vet_id = VET.id 
WHERE VET.name = 'Stephanie Mendez' 
AND V.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT A.name AS animal_name, COUNT(A.name) AS visits 
FROM animals A 
JOIN visits V 
ON A.id=V.animal_id 
GROUP BY A.name 
ORDER BY COUNT(A.name) DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT V.name AS vet_name, A.name AS animal_name, VET.visit_date 
FROM vets V 
JOIN visits VET 
ON V.id=VET.vet_id 
JOIN animals A 
ON VET.animal_id = A.id 
WHERE V.name='Maisy Smith' 
ORDER BY VET.visit_date ASC LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT A.name AS animal_name, V.name AS vet_name, VET.visit_date 
FROM vets V 
JOIN visits VET 
ON V.id = VET.vet_id 
JOIN animals A 
ON VET.animal_id = A.id  
ORDER BY VET.visit_date DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) FROM visits V 
JOIN animals A 
ON V.animal_id = A.id 
JOIN vets VET 
ON V.vet_id = VET.id 
FULL JOIN specializations S 
ON VET.id=S.vet_id 
WHERE A.species_id 
NOT IN ( SELECT species_id FROM specializations WHERE vet_id = V.vet_id );

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT S.name AS species, COUNT(*) 
FROM visits V 
JOIN animals A 
ON V.animal_id = A.id 
JOIN vets VET 
ON V.vet_id = VET.id 
JOIN species S 
ON A.species_id = S.id 
WHERE VET.name='Maisy Smith' 
GROUP BY S.name 
ORDER BY COUNT(*) DESC LIMIT 1;
