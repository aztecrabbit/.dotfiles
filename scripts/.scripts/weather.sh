#!/bin/sh

echo "Weather"

while true; do
    while ! httping -c 1 wttr.in >/dev/null 2>&1; do
        sleep 30
    done

    curl -s 'http://wttr.in/Dramaga?format=%C++%t\n' | sed -E 's/[°\+]//g'
    sleep $((3600*1))
done
