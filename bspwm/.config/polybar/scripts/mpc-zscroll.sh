#!/bin/bash

length=32
characters="$(printf ' %.0s' $(eval "echo {1.."$(($length))"}"))"

check_mpc()
{
    if ! mpc > /dev/null 2>&1; then
		echo
        exit 1
	fi
}

check_mpc
current_song="$(mpc current)"
echo ${current_song:0:$length}

while true; do
	check_mpc

    if mpc | grep -q playing; then
        ( mpc current | zscroll -l $length -d 0.25 -p "$characters" -n true ) 2> /dev/null &
    fi

    mpc idle > /dev/null 2>&1
	killall -q zscroll
done
