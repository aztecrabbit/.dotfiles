#!/bin/dash

path="$1"
delay="$2"

if [ ! "$path" -o ! "$delay" ]; then
    echo "Usage: \n  wallpaper-changer.sh (path/to/folder) (delay-in-seconds)"
    exit
fi

if [ ! -d "$path" ]; then
    echo "Directory not exists! \n  $path"
    exit
fi

cd "$path"

while true; do
    for filename in *; do
        if [ -e "$filename" ]; then
            echo "${path}/${filename}"
            nitrogen --save --set-zoom-fill "$filename" > /dev/null 2>&1
            sleep $delay
        fi
    done
done
