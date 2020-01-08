#!/bin/sh

# Terminate already running bar instances
killall -q polybar

status_generator="$HOME/.config/polybar/modules/scripts/status-generator"

kill $(cat ${status_generator}.pid)
python3 ${status_generator}.py 'enp0s29f7u7' 'wlxa0f3c10e5a99' &

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# Launch polybar
polybar top
