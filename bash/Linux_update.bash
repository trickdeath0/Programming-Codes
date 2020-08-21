#!bin/bash

echo "########################"
echo "Please enter your choise: "
echo "1. apt-get update"
echo "2. apt-get upgrade"
echo "3. apt-get full-upgrade"
echo "4. apt-get update && apt-get upgrade"
echo "Exit"
echo "########################"
read ch

if [ $ch -eq 1 ]; then
  apt-get update
 
elif [ $ch -eq 2 ]; then
  apt-get upgrade
  
elif [ $ch -eq 3 ]; then
  apt-get full-upgrade
 
elif [ $ch -eq 4 ]; then
  apt-get update && apt-get upgrade
  
elif [ $ch -eq 5 ]; then
  echo "Tnx you for use me"
  exit
fi
