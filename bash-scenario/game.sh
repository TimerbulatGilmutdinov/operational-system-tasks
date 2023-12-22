#!/bin/bash

declare -i hits
declare -i misses
declare -i step
declare -a target_numbers

RED='\e[31m'
GREEN='\e[32m'
RESET='\e[0m'

while true; do
  ((step++))
    echo "Step: ${step}"

    secret_digit=${RANDOM: -1}

    read -r -p "Please enter a number from 0 to 9 (q - quit): " input

    if [ "${input}" == "q" ]; then
        echo "Exiting the script"
        exit 0
    fi

    if ! [[ "${input}" =~ ^[0-9]$|q ]]; then
        echo "Invalid input. Please type one of 0-9 digits, or 'q' to exit."
        continue
    fi

    if [ "${input}" == "${secret_digit}" ]; then
        echo "Hit! My number: ${secret_digit}"
        ((hits++))
		    target_numbers+=("${GREEN}${secret_digit}${RESET}")
    else
        echo "Miss! My number: ${secret_digit}"
        ((misses++))
		    target_numbers+=("${RED}${secret_digit}${RESET}")
    fi

    hit_percent=$((hits * 100 / step))
    miss_percent=$((misses * 100 / step))

    echo "Hit: ${hit_percent}% Miss: ${miss_percent}%"

	target_numbers_length=${#target_numbers[@]}
	if (( target_numbers_length < 10 )); then
		echo -e "Numbers: ${target_numbers[@]}\n"
	else
		echo -e "Numbers: ${target_numbers[@]: -10}\n"
	fi
done