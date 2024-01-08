#!/bin/bash

notify-send -t 3000 "Refreshing Radio Playlist" "Please wait ..."

playlist_filepath="$HOME/.local/share/mpd/playlists/radio.m3u"

mkdir -p "$(dirname "$playlist_filepath")"

cat << EOF > "$playlist_filepath"
#EXTM3U
EOF

cat $HOME/.radio-active-alias | awk '{ split($0,a,"=="); print "\n#EXTINF:-1,"a[1]"\n"a[2] }' >> "$playlist_filepath"

sleep 1

notify-send -t 3000 "Radio Playlist Updated" "Happy Listening :)"

mpc clear && mpc load radio && mpc random on && mpc play
