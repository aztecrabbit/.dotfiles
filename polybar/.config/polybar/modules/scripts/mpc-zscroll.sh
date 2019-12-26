#!/bin/bash

length=48
characters="$(printf ' %.0s' $(eval "echo {1.."$(($length))"}"))"

while true; do
    # offline
    if ! mpc > /dev/null 2>&1; then
        echo
        exit 1

    # playing
    elif mpc | grep -q playing; then
        ( mpc current | zscroll -l $length -d 0.25 -p "$characters" -n true ) 2> /dev/null &

    fi

    mpc idle > /dev/null 2>&1
    killall zscroll > /dev/null 2>&1
done
