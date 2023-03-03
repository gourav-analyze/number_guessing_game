#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"

echo -e "\nEnter your username:"
read username

 get_username=$($PSQL "select * from users where username='$username'")
 games_played=$($PSQL "select count(*) from users inner join games using(user_id) where username='$username'")
 best_game=$($PSQL "select min(number_guesses) from users inner join games using(user_id) where username='$username'")

if [[ -z $get_username ]]
then
insert_username=$($PSQL "insert into users(username) values('$username')")
echo "Welcome, $username! It looks like this is your first time here."
else
echo "Welcome back, $username! You have played $games_played games, and your best game took $best_game guesses."
fi

# #genrates a random no betwwen 1 to 1000
win_number=$((1 + RANDOM % 1000))
echo "Guess the secret number between 1 and 1000:"
guess=1
while read user_guess
do
if [[ ! $user_guess =~ ^[0-9]+$ ]]
 then
 echo "That is not an integer, guess again:"
 else
  if [[ $user_guess -eq $win_number ]]
   then
   break;
   else
    if [[ $user_guess -gt $win_number ]]
      then
      echo -n "It's lower than that, guess again:"
      elif [[ $user_guess -lt $win_number ]]
      then
      echo -n "It's higher than that, guess again:"
    fi
  fi
fi
guess=$(( $guess + 1 ))
done

if [[ $guess == 1 ]]
then
 echo "You guessed it in $guess tries. The secret number was $win_number. Nice job!"
else
 echo "You guessed it in $guess tries. The secret number was $win_number. Nice job!"
fi

user_id=$($PSQL "select user_id from users where username='$username'")
insert_game=$($PSQL "insert into games(number_guesses, user_id) values($guess, $user_id)")

 






