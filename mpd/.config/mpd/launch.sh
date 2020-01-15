#!/bin/dash

mkdir -p ~/.local/share/mpd/playlists

# killall -q -w -e mpd
# mpd --kill

if [ ! "$(pidof mpd)" ]; then
    mpd ~/.config/mpd/mpd.conf
    mpc load playlist
fi
