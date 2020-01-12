#!/bin/dash

mode="$1"
command='scrot --quality 50'

mkdir -p $HOME/Pictures/Screenshots/

if [ "$mode" = 'select' -o "$mode" = 'freeze' -o "$mode" = 'freeze-now' ]; then
    command="tabbed -n urxvt-scrot -c -r 2 urxvtc -embed '' -e $command --select"
    message='Screenshot select mode'
fi

if [ "$mode" = 'freeze-now' ]; then
    command="$command --freeze"
    message=''
fi

if [ "$mode" = 'freeze' ]; then
    command="$command --freeze"
    message=''

    notify-send -t 3000 'Screenshot, freezing in'
    notify-send -t 2900 '3'
    sleep 1
    notify-send -t 1900 '2'
    sleep 1
    notify-send -t  900 '1'
    sleep 1
fi

if [ "$message" ]; then
    notify-send -t 2000 "$message"
fi

$command --exec 'mv $f ~/Pictures/Screenshots/ && notify-send -t 2000 -i ~/Pictures/Screenshots/$f "Screenshot saved!"'
