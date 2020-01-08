#!/bin/sh

mkdir -p ~/.local/share/mpd/playlists

# killall -q -w mpd
mpd ~/.config/mpd/mpd.conf
mpc load playlist
