#!/bin/bash

if [[ -z "$1" ]] || [[ -z "$2" ]]; then
    echo "Usage: $0 ~/path/to/folder delay-in-seconds"
    exit
fi

if [[ ! -e "$1" ]]; then
    echo "Directory not exists!"
    exit
fi

cd "$1"

while true; do
    for x in *; do
        if [ ! -z $x ]; then
            echo "${1}/${x}"
            feh --no-fehbg --bg-center $x
            sleep $2
        fi
    done
done
