#!/bin/sh

xmodmap ~/.Xmodmap &
nitrogen --restore &
xsetroot -cursor_name left_ptr &

{
    mkdir -p ~/.local/share/mpd/playlists
    mpd ~/.config/mpd/mpd.conf
} &

{
    killall -q -w xfce4-notifyd dunst
    dunst
} &

if [ "$1" ]; then
	exec "$1"
else
	exec xmonad
fi
