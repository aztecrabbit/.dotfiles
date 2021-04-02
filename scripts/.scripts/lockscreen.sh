#!/bin/sh

bg='/tmp/background-lock.png'

scrot $bg --overwrite --quality 100
convert $bg -blur 2x8 $bg && i3lock --image $bg &

notify-send -t 3000 'Screen will be locked' 'Please wait...'
