#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE TABLE games, teams;")

#Insert team into table teams
cat gamescopy.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNERGOALS OPPONENTGOALS
do
  if [[ $YEAR != "year" ]]
  then
    #get winner team id
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")

    #if winner team id is not found
    if [[ -z $WINNER_ID ]]
    then
      #insert winner team id into table teams
      INSERT_WINNER_ID_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER');")
      if [[ $INSERT_WINNER_ID_RESULT == "INSERT 0 1" ]]
      then
        echo "Inserted into TEAMS, $WINNER"
      fi

      #get newly inserted winner team id
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    fi

    #get opponent team id
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")

    #if opponent team id is not found
    if [[ -z $OPPONENT_ID ]]
    then
      #insert opponent team id into table teams
      INSERT_OPPONENT_ID_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT');")
      if [[ $INSERT_OPPONENT_ID_RESULT == "INSERT 0 1" ]]
      then
        echo "Inserted into TEAMS, $OPPONENT"
      fi

      #get newly inserted opponent team id
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
    fi

    #insert data into games
    INSERT_GAMES_RESULT=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNERGOALS, $OPPONENTGOALS);")
    if [[ $INSERT_GAMES_RESULT == "INSERT 0 1" ]]
      then
        echo "Inserted into GAMES, $YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNERGOALS, $OPPONENTGOALS"
      fi
  fi
done

