#!/bin/bash

mode="$1"
command="scrot --quality 75"

mkdir -p ~/Pictures/Screenshots

if [ "$mode" = "select" -o "$mode" = "freeze" -o "$mode" = "freeze-now" ]; then
    command="$command --select"
fi

case "$mode" in
    select )
        notify-send -t 2000 "Screenshot select mode"
        ;;

    freeze )
        command="$command --freeze"

        notify-send -t 2950 "Screenshot, freezing in"
        notify-send -t 2900 "3"
        sleep 1
        notify-send -t 1900 "2"
        sleep 1
        notify-send -t  900 "1"
        sleep 1
        ;;

    freeze-now )
        command="$command --freeze"
        ;;
esac

$command --exec 'mv $f ~/Pictures/Screenshots/ && notify-send -t 2000 -i ~/Pictures/Screenshots/$f "Screenshot saved!"'

if [ "$?" = "1" ]; then
    notify-send -t 2000 "Screenshot canceled!"
fi
