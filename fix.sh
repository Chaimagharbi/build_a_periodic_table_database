#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
DELETE_1000_PROPERTIES=$($PSQL "DELETE FROM properties WHERE atomic_number=1000")
DELETE_1000_ELEMENTS=$($PSQL "DELETE FROM elements WHERE atomic_number=1000")
DELETE_TYPE_COLUMN_PROPERTIES=$($PSQL "ALTER TABLE properties DROP COLUMN type")
