#!/bin/bash

mpc clear
mpc stop
find "$(cd ~/Music/Playing; pwd -P)" -type f \( -name '*.mp3' -o -name '*.flac' -o -name '*.loss' -o -name '*.aiff' -o -name '*.aif' \) -exec ls -d {} \; | sort > ~/.local/share/mpd/playlists/playlist.m3u
mpc load playlist
mpc random on
mpc play
