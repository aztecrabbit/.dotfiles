#!/bin/dash

pkill -USR1 -x sxhkd

sxhkd > /dev/null 2>&1 &

