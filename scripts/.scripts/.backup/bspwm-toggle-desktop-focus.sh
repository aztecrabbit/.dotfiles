#!/bin/dash

desktop_target="$(bspc query -D -d $1)"
desktop_active="$(bspc query -D -d .active)"

if [ "$desktop_target" = "$desktop_active" ]; then
    bspc desktop -f last
else
    bspc desktop -f $desktop_target
fi
