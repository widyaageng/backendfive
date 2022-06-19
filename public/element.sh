#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
if [[ -z $1 ]]
then
  echo -e "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ELEMENT_QUERIED=$($PSQL "SELECT
    atomic_number,
    name,
    symbol,
    types.type,
    atomic_mass,
    melting_point_celsius,
    boiling_point_celsius
    FROM elements LEFT JOIN properties USING(atomic_number)
    LEFT JOIN types USING(type_id)
    WHERE atomic_number=$1;")
  elif [[ $1 =~ ^[A-Z]+[a-z]{,1}$ ]]
  then
    ELEMENT_QUERIED=$($PSQL "SELECT
    atomic_number,
    name,
    symbol,
    types.type,
    atomic_mass,
    melting_point_celsius,
    boiling_point_celsius
    FROM elements LEFT JOIN properties USING(atomic_number)
    LEFT JOIN types USING(type_id)
    WHERE symbol='$1';")
  elif [[ $1 =~ ^[A-Z]+[a-z]{2,}$ ]]
  then
    ELEMENT_QUERIED=$($PSQL "SELECT
    atomic_number,
    name,
    symbol,
    types.type,
    atomic_mass,
    melting_point_celsius,
    boiling_point_celsius
    FROM elements LEFT JOIN properties USING(atomic_number)
    LEFT JOIN types USING(type_id)
    WHERE name='$1';")
  else
    :
  fi

  if [[ -z $ELEMENT_QUERIED ]]
  then
    echo "I could not find that element in the database."
  else
    echo $ELEMENT_QUERIED | while read ATOMICNUMBER BAR NAME BAR SYMBOL BAR TYPE BAR ATOMICMASS BAR MELTPOINT BAR BOILPOINT
    do
      echo "The element with atomic number $ATOMICNUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMICMASS amu. $NAME has a melting point of $MELTPOINT celsius and a boiling point of $BOILPOINT celsius."
    done
  fi
fi
