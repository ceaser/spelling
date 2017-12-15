#!/bin/bash

if [ -z "$1" ]
then
  # Check if the first argument is used
  echo "Example: $@ <file>"
  exit
fi


# Loop through each word in the list
for word in `cat $1`
do
  clear
  echo "Press the letters each word"
  echo "Press the Return/Enter key to repeat the word"
  echo "Hold the Control/CTRL and the c key to exit"

  # Initialize or reset the progress
  progress=""
  # Say it
  say $word

  # Loop through each letter in the word
  for letter in `echo $word | fold -w1`
  do

    # Keep looping. Until a break is ran before going to the next letter
    while true
    do

      # Read the character from the keyboard
      read -n 1 c

      # if the letter matches the character
      if [ "$letter" == "$c" ]
      then
        # Say the letter
        say $letter

        # Save the correct progress
        progress="$progress$letter"

        # break the loop and go to the next letter.
        break
      fi

      # if the character is blank say the word
      if [ -z "$c" ]
      then
        say $word
        echo -n "$progress"
        continue
      fi

      # Got here so it must be wrong. Start the loop again
      say "Wrong"
      echo ""
      echo -n "$progress"
    done

  done

  # Got here after all letter where typed in. Repeat the word.
  echo
  echo "Correct: $word"
  say $word

  # Wait before saying next word
  echo "Press any key to continue"
  read
done
