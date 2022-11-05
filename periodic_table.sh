#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

MAIN() {
  #1 if input is a number
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    
    ATOMIC_NUMBER_I=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1")

    #SEARCH IF ELEMENT EXIST IN THE DATABASE
    if [[ -z $ATOMIC_NUMBER_I ]]
    then
    # NOT FOUND
      NOT_FOUND

    else
    #do what must be done
      INFO=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number = $ATOMIC_NUMBER_I")

      echo "$INFO" | while read NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR MASS BAR MELTING BAR BOILING
        do
            echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
        done

    fi
    
  #2 if input is not a number
  else
    #3CHECK IF INPUT IS SYMBOL
    if [[ $1 == [A-Z] || $1 == [A-Z][a-z] ]]
    then

      ATOMIC_NUMBER_I=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
      #SEARCH IF ELEMENT EXIST IN THE DATABASE
      if [[ -z $ATOMIC_NUMBER_I ]]
      then
      # NOT FOUND
        NOT_FOUND

      else
      #do what must be done
        INFO=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number = $ATOMIC_NUMBER_I")

        echo "$INFO" | while read NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR MASS BAR MELTING BAR BOILING
        do
            echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
        done

      fi
      
    else
    #4CHECK IF INPUT IS NAME
      if [[ $1 =~ ^[A-Z]+ ]]
      
      then
        ATOMIC_NUMBER_I=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
        #SEARCH IF ELEMENT EXIST IN THE DATABASE
        if [[ -z $ATOMIC_NUMBER_I ]]
        then
        # NOT FOUND
          NOT_FOUND
        else
        #do what must be done
          INFO=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements LEFT JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE atomic_number = $ATOMIC_NUMBER_I")

          echo "$INFO" | while read NUMBER BAR NAME BAR SYMBOL BAR TYPE BAR MASS BAR MELTING BAR BOILING
          do
            echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
          done
        fi

      else
      #NOT A SYMBOL, NOT A NAME
      NOT_FOUND
      fi
    fi
  fi
}

#CAN NOT FIND A MATCH
NOT_FOUND() {
  echo "I could not find that element in the database."
}

if [[ $1 ]]
  then
    MAIN $1 
  else 
    echo -e "Please provide an element as an argument."
  fi



