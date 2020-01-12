#!/bin/dash

command="$1"
application_name="$2"
notification_timeout="$3"

message="Shortcut not set!"

if [ ! "$notification_timeout" ]; then
    notification_timeout="3000"
fi

if [ "$command" ]; then
    if [ "$application_name" ]; then
        message="Launching $application_name ..."
    else
        message=''
    fi
fi

if [ "$message" ]; then
    notify-send -t $notification_timeout "$message"
fi

if [ "$command" ]; then
    $command > /dev/null 2>&1 &
fi
