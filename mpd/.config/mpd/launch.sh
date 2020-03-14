#!/bin/dash

mkdir -p ~/.local/share/mpd/playlists

# killall -q -w -e mpd
# mpd --kill

if [ ! "$(pidof mpd)" ]; then
    sleep 30
    mpd ~/.config/mpd/mpd.conf
    # mpc clear
    # mpc load playlist
fi
