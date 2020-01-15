#!/bin/dash

background='/tmp/background-lock.png'

scrot $background --overwrite --quality 100
convert $background -blur 2x8 $background && i3lock --image $background &

notify-send -t 3000 'Screen will be locked' 'Please wait...'
