#!/bin/sh

~/.fehbg &
xsetroot -bg "#000000" -cursor_name left_ptr &

if [ "$1" ]; then
    exec "$1"
else
    exec xmonad
fi
