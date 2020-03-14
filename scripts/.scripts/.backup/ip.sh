#!/bin/bash

interval=1

while true; do
    result="$(ip route get 1 2> /dev/null)" && echo $result | awk '{print $7}' || echo "127.0.0.1"

    sleep $interval
done
