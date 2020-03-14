#!/bin/dash

killall -q xfce4-notifyd dunst

dunst > /dev/null 2>&1 &

