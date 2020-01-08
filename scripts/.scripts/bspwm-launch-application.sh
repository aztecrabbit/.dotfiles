#!/bin/bash

command="$1"
application_name="$2"

if [[ "$application_name" ]]; then
    message="Launching $application_name ..."
else
    message="Launching..."
fi

if [[ "$command" ]]; then
    notify-send -t 3000 "$message"
    $command &
else
    notify-send -t 3000 'Shortcut not set!'
fi
