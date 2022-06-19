#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
NUMBER=$((RANDOM%1000 + 1))
# echo $NUMBER
echo -e "Enter your username:"
read USERNAME

USERNAME_ACTUAL=$($PSQL "SELECT username FROM users WHERE username='$USERNAME';")
if [[ -z $USERNAME_ACTUAL ]]
then
  echo -e "Welcome, $USERNAME! It looks like this is your first time here."

  #register new user
  USERNAME_INSERT_RESULT=$($PSQL "INSERT INTO users(username,best_game) VALUES('$USERNAME', 999999);")
  BESTGAME=999999
  if [[ $USERNAME_INSERT_RESULT == "INSERT 0 1" ]]
  then
    USERNAME_ACTUAL=$($PSQL "SELECT username FROM users WHERE username='$USERNAME';")
    UPDATE_GAMESPLAYED=$($PSQL "UPDATE users SET games_played = games_played + 1 WHERE username='$USERNAME';")
  else
    echo -e "ERROR: New user insertion has failed."
  fi
else

  #get number of games
  GAMESPLAYED=$($PSQL "SELECT games_played FROM users WHERE username='$USERNAME';")
  GAMECOUNT="games"

  #get the bestgame
  BESTGAME=$($PSQL "SELECT best_game FROM users WHERE username='$USERNAME';")
  BESTGAMECOUNT="guesses"

  if [[ $GAMESPLAYED == 1 ]]
  then
    GAMECOUNT="game"
  fi

  if [[ $BESTGAME == 1 ]]
  then
    BESTGAMECOUNT="guess"
  fi

  echo -e "Welcome back, $USERNAME_ACTUAL! You have played $GAMESPLAYED $GAMECOUNT, and your best game took $BESTGAME $BESTGAMECOUNT."

  UPDATE_GAMESPLAYED=$($PSQL "UPDATE users SET games_played = games_played + 1 WHERE username='$USERNAME';")
fi

TRIALNUMBER=0
echo -e "Guess the secret number between 1 and 1000:"
USERGUESS=-1
while [[ $USERGUESS != $NUMBER ]]
do
  #Init guess
  if [[ $USERGUESS == -1 ]]
  then
    read USERGUESS
    TRIALNUMBER=$((TRIALNUMBER+1))
  fi

  if [[ $USERGUESS =~ ^[1-9][0-9]*$ ]]
  then
    if [[ $USERGUESS -lt $NUMBER ]]
    then
      echo -e "It's higher than that, guess again:"
      read USERGUESS
      TRIALNUMBER=$((TRIALNUMBER+1))
    elif [[ $USERGUESS -gt $NUMBER ]]
    then
      echo -e "It's lower than that, guess again:"
      read USERGUESS
      TRIALNUMBER=$((TRIALNUMBER+1))
    else
      :
    fi
  elif [[ $USERGUESS == 0 ]]
  then
    echo -e "That is not an integer, guess again:"
    read USERGUESS
    TRIALNUMBER=$((TRIALNUMBER+1))
  else
    echo -e "That is not an integer, guess again:"
    read USERGUESS
    TRIALNUMBER=$((TRIALNUMBER+1))
  fi
done

if [[ $TRIALNUMBER -lt $BESTGAME ]]
then
  UPDATE_BESTGAME=$($PSQL "UPDATE users SET best_game=$TRIALNUMBER WHERE username='$USERNAME';")
fi

if [[ $TRIALNUMBER -gt 1 ]]
then
  echo -e "You guessed it in $TRIALNUMBER tries. The secret number was $NUMBER. Nice job!"
else
  echo -e "You guessed it in $TRIALNUMBER try. The secret number was $NUMBER. Nice job!"
fi
