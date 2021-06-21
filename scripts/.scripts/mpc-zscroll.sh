#!/bin/bash

len=32
pad="$(printf "%${len}s" ' ')"

while true; do
    if ! mpc >/dev/null 2>&1; then
        echo
        exit 1

    elif mpc | grep -q playing; then
        mpc current | tr -d '\n' | zscroll -n true -d 0.25 -l "$len" -p "$pad" 2>/dev/null &

    else
        echo "$(mpc current | cut -c "1-$len")"

    fi

    mpc idle >/dev/null 2>&1

    killall -q zscroll

done
