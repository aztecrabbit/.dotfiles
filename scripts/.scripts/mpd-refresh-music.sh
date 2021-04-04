#!/bin/bash

notify-send -t 3000 "Updating Music Playlist" "Please wait ..."

playlist_source_directory="$(cd $HOME/Music; pwd -P)"

playlist="$(find "$playlist_source_directory" -type f \( -name '*.mp3' -o -name '*.flac' -o -name '*.loss' -o -name '*.aiff' -o -name '*.aif' \) -exec ls -d {} \; | sort)"
playlist_filepath="$HOME/.local/share/mpd/playlists/music.m3u"

mkdir -p "$(dirname "$playlist_filepath")"

cat << EOF > "$playlist_filepath"
#EXTM3U

$playlist
EOF

notify-send -t 3000 "Music Playlist Updated" "Happy Listening :)"

mpc clear && mpc load music && mpc random on && mpc play
