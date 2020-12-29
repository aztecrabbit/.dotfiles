#!/bin/bash

length=32
characters="$(printf ' %.0s' $(eval "echo {1.."$(($length))"}"))"

while true; do
    if ! mpc > /dev/null 2>&1; then
		echo
        exit 1

	elif mpc | grep -q playing; then
        ( mpc current | zscroll -l $length -d 0.25 -p "$characters" -n true ) 2> /dev/null &

	else
		current_song="$(mpc current)"
		echo ${current_song:0:$length}
    fi

    mpc idle > /dev/null 2>&1
	killall -q zscroll
done
