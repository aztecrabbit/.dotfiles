#!/bin/bash

if [ "$1" ]; then
    exec "$1"
else
    exec xmonad
fi
