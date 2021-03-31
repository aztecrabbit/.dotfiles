#!/bin/bash

nitrogen --restore &
xsetroot -cursor_name left_ptr &

{
    mkdir -p ~/.local/share/mpd/playlists
    mpd ~/.config/mpd/mpd.conf
} &

exec bspwm
