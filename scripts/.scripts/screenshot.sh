#!/bin/bash

mode="$1"
command='scrot --quality 50'

mkdir -p $HOME/Pictures/Screenshots/

if [ "$mode" = 'select' -o "$mode" = 'freeze-now' -o "$mode" = 'freeze' ]; then
    command="$command --select"
    command_delay="1"
fi

if [ "$mode" = 'select' ]; then
    notify-send -t 2000 'Screenshot select mode'
fi

if [ "$mode" = 'freeze-now' ]; then
    command="$command --freeze"
fi

if [ "$mode" = 'freeze' ]; then
    command="$command --freeze"

    notify-send -t 2950 'Screenshot, freezing in'
    notify-send -t 2900 '3'
    sleep 1
    notify-send -t 1900 '2'
    sleep 1
    notify-send -t  900 '1'
fi

if [ "$command_delay" ]; then
    sleep "$command_delay"
fi

if ! $command --exec \
    'mv $f ~/Pictures/Screenshots/ && notify-send -t 2000 -i ~/Pictures/Screenshots/$f "Screenshot saved!"'
then
    notify-send -t 3000 'Screenshot canceled!'
fi
