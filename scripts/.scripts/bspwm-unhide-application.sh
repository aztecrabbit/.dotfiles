#!/bin/dash

desktop_id="$1"

node_id="$(bspc query -N -n .hidden | tail -n1)"
node_id_urxvt_popup="$(xdo id -N URxvt -n popup)"

if [ "$node_id" = "$node_id_urxvt_popup" ]; then
    node_id="$(bspc query -N -n .hidden | tail -n2 | awk 'NR==1')"
fi

if [ "$node_id" != "$node_id_urxvt_popup" ]; then
    command="bspc node $node_id -g hidden=off --focus"

    if [ "$desktop_id" ]; then
        command="$command -d $desktop_id --follow"
    fi

    $command
else
    notify-send -t 3000 'No hidden app!'
fi
