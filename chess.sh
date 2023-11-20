#!/usr/bin/env bash
# 112314001

set -e
set -o nounset

if [ -z "${1-}" ]; then
	>&2 echo "USAGE: $0 n"
	exit 1
fi

if [ -z "$(echo "$1"|grep -E '^[0-9]+$')" ]; then
	>&2 echo "USAGE: $0 n, where n is a positive integer"
	exit 1
fi

n="$1"

for (( i = 0; i < $n; i++ )); do
	for (( j = 0; j < $n; j++ )); do
		if (( (i + j) % 2 )); then
			echo -ne "\e[48;5;255m \e[0m"
		else
			echo -ne "\e[48;5;235m \e[0m"
		fi
	done

	echo -e "\n"
done
