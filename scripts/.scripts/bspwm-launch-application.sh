#!/bin/bash

command="$1"
application_name="$2"
notification_timeout="$3"

if [[ ! -z "$application_name" ]]; then
    message="Launching $application_name ..."
else
    message="Launching..."
fi

if [[ -z $notification_timeout ]]; then
    notification_timeout=3000
fi

if [[ ! -z "$command" ]]; then
    notify-send -t $notification_timeout "$message"
    $command &
else
    notify-send -t $notification_timeout 'Shortcut not set!'
fi
