#!/bin/sh

while true; do
    while ! ping -c 1 wttr.in >/dev/null 2>&1; do
        echo "Weather"
        sleep 30
    done

    curl -s 'http://wttr.in/Dramaga?format=%C++%t\n' | sed -E 's/[°\+]//g'
    sleep $((3600*3))
done
