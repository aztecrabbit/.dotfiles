#!/bin/sh

if [ -z "$1" ]; then
    notify-send -t "3000" "Shortcut not set!"
    exit 1
fi

cmd="$1"
app_name="$2"
notification_timeout="$3"

if [ "$app_name" ]; then
    notify-send -t "${notification_timeout:-"3000"}" "Launching $app_name ..."
fi

$cmd > /dev/null 2>&1 &
