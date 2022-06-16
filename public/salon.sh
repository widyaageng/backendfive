#!/bin/bash
PSQL="psql --username=freecodecamp --tuples-only --dbname=salon -c"
echo -e "\n~~~~ Welcome to Bufoon Salon ~~~~\n"

SERVICES=$($PSQL "SELECT service_id,name FROM services;")

MAIN_MENU () {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  if [[ -z $SERVICES ]]
  then
    echo "We don't have available services right now."
  else
    echo -e "\nPlease pick a service you would like to have?"
    echo "$SERVICES" | while read SERVICEID BAR SERVICENAME
    do
      echo "$SERVICEID) $SERVICENAME"
    done
    read SERVICE_ID_SELECTED

    #get service_id
    SERVICE_ID=$($PSQL "SELECT service_id FROM services WHERE service_id=$SERVICE_ID_SELECTED;")

    #if service_id doesnt exist
    if [[ -z $SERVICE_ID ]]
    then
      #send to top main menu
      MAIN_MENU "Sorry, that service is not in the list."
    else
      #get selected service type
      SERVICE_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED;")

      #get phone number input
      echo -e "\nPlease enter your phone number:"
      read CUSTOMER_PHONE

      #get customer_id
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE';")

      #if customer doesnt exist => register
      if [[ -z $CUSTOMER_ID ]]
      then
        #get name input
        echo -e "\nIt seems you are not yet registered as customer, sign up for free."
        echo -e "\nPlease enter your name:"
        read CUSTOMER_NAME

        #insert into customers table
        CUSTOMER_INSERT_RESULT=$($PSQL "INSERT INTO customers(phone,name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME');")
        if [[ $CUSTOMER_INSERT_RESULT == "INSERT 0 1" ]]
        then
          echo -e "\nCongratulations, you are now registered customer."
        fi
        #get customer_id
        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE';")
      fi

      #get customer name
      CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE';")

      #get service_time
      echo -e "\nPlease enter requested service time slot with format (HH:MM) for examples 15:30, 08:20, :"
      read SERVICE_TIME

      #check if service_time entry is in correct format
      while [[ ! $SERVICE_TIME =~ ^([0-9]{2}:[0-9]{2})|([0-9]{2,4}(am|pm))$ ]]
      do
        #redo the input request due to incorrect format
        echo -e "\nThat's in incorrect format. Please try again.\nPlease enter requested service time slot with format (HH:MM) for examples 15:30, 08:20, :"
        read SERVICE_TIME
      done

      #insert into services table
      SERVICE_INSERT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID,$SERVICE_ID,'$SERVICE_TIME');")
      if [[ $SERVICE_INSERT_RESULT == "INSERT 0 1" ]]
      then
        echo -e "\nI have put you down for a $SERVICE_SELECTED at $SERVICE_TIME, $CUSTOMER_NAME."
      fi
    fi
  fi
}
MAIN_MENU
