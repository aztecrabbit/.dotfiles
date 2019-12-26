#!/bin/bash

mkdir ~/.local/share/mpd
mkdir ~/.local/share/mpd/playlists

mpd --kill
mpd ~/.config/mpd/mpd.conf
mpc load playlist
