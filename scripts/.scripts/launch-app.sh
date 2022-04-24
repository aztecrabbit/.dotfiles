#!/bin/bash

cmd="$1"
app_name="$2"
notification_timeout="$3"

if [ -z "$cmd" ]; then
    notify-send -t "3000" "Command not set!"
    exit 1
fi

if [ "$app_name" ]; then
    notify-send -t "${notification_timeout:-"3000"}" "Launching $app_name ..."
fi

$cmd > /dev/null 2>&1 &
