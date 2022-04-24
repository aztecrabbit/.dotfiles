#!/bin/bash

song="$(mpc current)"
song_list_file="$HOME/.notes-songs"

notify-send -t 3000 "Saving Current Playing Song" "$song"
echo "$song" >> "$song_list_file"
