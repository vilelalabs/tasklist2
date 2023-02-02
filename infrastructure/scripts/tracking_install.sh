#!/bin/bash

# Spinner icons
spinner=( '\' '|' '/' '-' )

while true; do
  for i in "${spinner[@]}"; do
    tput cuu1 # move cursor up one line
    tput el   # clear line
    echo "$i $(tail -n 1 log.txt)"
    sleep 0.1
  done
done