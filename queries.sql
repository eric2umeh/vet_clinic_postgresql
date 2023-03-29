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
