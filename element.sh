#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
if [[ -z $1 ]]
then 
  echo "Please provide an element as an argument."
elif [[ $1 =~ ^[0-9]+$ ]]
then
  ELEMENT_RESULT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$1")
else 
  ELEMENT_RESULT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$1' OR name='$1'")
fi
if [[ -z $ELEMENT_RESULT && $1 ]]
then
  echo "I could not find that element in the database."
elif [[ $ELEMENT_RESULT ]]
then
  echo $ELEMENT_RESULT | while IFS="|" read TYPE_ID ATM_NUM SYM ELM ATM_MAS MPC BPC TYPE
  do
    SYM=$(echo $SYM | sed -E 's/^ *| *$//g')
    TYPE=$(echo $TYPE | sed -E 's/^ *| *$//g')
    echo "The element with atomic number"$ATM_NUM "is"$ELM"("$SYM"). It's a "$TYPE", with a mass of"$ATM_MAS"amu."$ELM"has a melting point of"$MPC"celsius and a boiling point of"$BPC"celsius."
  done 
fi